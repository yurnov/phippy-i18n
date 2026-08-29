#!/usr/bin/env python3
"""Minimal PDF text extractor: pure stdlib, good enough for simple text PDFs."""
import re, sys, zlib

def tokens_of(data):
    """Yield (obj_num, gen, body_bytes) for every `N G obj ... endobj`."""
    for m in re.finditer(rb'(\d+)\s+(\d+)\s+obj\b(.*?)\bendobj', data, re.S):
        yield int(m.group(1)), int(m.group(2)), m.group(3)

def inflate(body):
    m = re.search(rb'stream\r?\n', body)
    if not m:
        return None
    raw = body[m.end():]
    raw = re.sub(rb'\s*endstream\s*$', b'', raw)
    if b'/FlateDecode' in body[:m.start()]:
        try:
            return zlib.decompress(raw)
        except zlib.error:
            try:
                return zlib.decompressobj().decompress(raw)
            except Exception:
                return None
    return raw

def expand_objstm(data):
    """Return dict obj_num -> body for objects packed in /ObjStm streams."""
    out = {}
    for num, gen, body in tokens_of(data):
        if b'/ObjStm' not in body:
            continue
        d = inflate(body)
        if not d:
            continue
        n = int(re.search(rb'/N\s+(\d+)', body).group(1))
        first = int(re.search(rb'/First\s+(\d+)', body).group(1))
        hdr = d[:first].split()
        for i in range(n):
            onum, off = int(hdr[2 * i]), int(hdr[2 * i + 1])
            end = int(hdr[2 * i + 3]) + first if i + 1 < n else len(d)
            out[onum] = d[first + off:end]
    return out

def unescape(s):
    rep = {b'\\n': b'\n', b'\\r': b'\r', b'\\t': b'\t', b'\\(': b'(',
           b'\\)': b')', b'\\\\': b'\\'}
    for k, v in rep.items():
        s = s.replace(k, v)
    # octal escapes are cp1252 code points (curly quotes, dashes, ellipsis)
    s = re.sub(rb'\\([0-7]{1,3})',
               lambda m: bytes([int(m.group(1), 8) & 0xFF]), s)
    return s.decode('cp1252', 'replace').encode('utf-8')

def strings_from_content(c):
    """Pull text out of Tj / TJ / ' / " operators, tracking line breaks.

    Numeric kern adjustments inside TJ arrays stand in for spaces in the
    subset-font pages, so treat a large negative adjustment as a space.
    """
    out = []
    pat = (rb'\((?:[^()\\]|\\.)*\)|<[0-9A-Fa-f\s]+>|-?\d+(?:\.\d+)?'
           rb'|T[Jj*]|Td|TD|ET')
    for m in re.finditer(pat, c):
        t = m.group(0)
        if t in (b'Td', b'TD', b'T*', b'ET'):
            out.append('\n')
        elif t[:1].isdigit() or t[:1] == b'-':
            try:
                if float(t) <= -120:
                    out.append(' ')
            except ValueError:
                pass
        elif t.startswith(b'('):
            out.append(unescape(t[1:-1]).decode('utf-8', 'replace'))
        elif t.startswith(b'<'):
            h = re.sub(rb'\s', b'', t[1:-1])
            try:
                b = bytes.fromhex(h.decode())
                # heuristic: 2-byte CID -> try utf-16be, else latin-1
                out.append(b.decode('utf-16-be') if len(b) % 2 == 0 else b.decode('latin-1'))
            except Exception:
                pass
    return ''.join(out)

LIG = {'æ': 'fi', 'ç': 'fl', 'Þ': ' '}

def deshift(txt):
    """Some pages embed a subset font whose codes sit 29 above the real
    character; those runs come out as mojibake like `VHUYHU` for `server`."""
    # Decide per line, not per word: a whole line comes from one font, and
    # word-by-word guessing leaves half-decoded lines.
    out = []
    for line in txt.split('\n'):
        dec = _shift(line)
        out.append(dec if _vowels(dec) > _vowels(line) else line)
    return '\n'.join(out)

def _shift(s):
    return ''.join(LIG.get(c, chr(ord(c) + 29)) if 0x20 < ord(c) < 0xE0 else c
                   for c in s)

def _vowels(s):
    return sum(c in 'aeiouAEIOU' for c in s)

def main(path):
    data = open(path, 'rb').read()
    bodies = {n: b for n, g, b in tokens_of(data)}
    bodies.update(expand_objstm(data))
    pages = [n for n, b in bodies.items() if re.search(rb'/Type\s*/Page\b', b)]
    print(f'# {path}: {len(bodies)} objects, {len(pages)} page objects', file=sys.stderr)
    for n in sorted(pages):
        body = bodies[n]
        kids = re.findall(rb'/Contents\s+(?:(\d+)\s+\d+\s+R|\[([^\]]*)\])', body)
        refs = []
        for a, b in kids:
            refs += [int(a)] if a else [int(x) for x in re.findall(rb'(\d+)\s+\d+\s+R', b)]
        txt = ''
        for r in refs:
            src = data if r in {k for k, g, v in tokens_of(data)} else None
            raw = None
            for num, gen, bd in tokens_of(data):
                if num == r:
                    raw = inflate(bd)
                    break
            if raw:
                txt += strings_from_content(raw)
        txt = deshift(txt)
        txt = re.sub(r'[ \t]{2,}', ' ', txt)
        txt = re.sub(r'\n{2,}', '\n', txt).strip()
        if txt:
            print(f'\n===== page obj {n} =====')
            print(txt)

if __name__ == '__main__':
    main(sys.argv[1])
