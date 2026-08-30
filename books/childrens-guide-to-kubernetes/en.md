---
lang: en
language: English
title: The Illustrated Children's Guide to Kubernetes
status: source
translators:
reviewers:
---

Source text, transcribed from the published CNCF PDF. **Do not rewrite.** Every other
language file in this directory is translated from here, and the page numbers are the
ones the PDF actually uses.

The story and note wording comes from the PDF's live text layer. The note titles and
bullets are not in that layer — they were flattened into the page images — and were
transcribed by eye.

Two typos in the original are corrected here, because there is no point translating a
misspelling: p9 reads "Philsophia" and p17 reads "Kurbernetes".

## p1 — cover

The cover title, one list item per typeset line. `{word}` is the red-pen
insertion written in above a caret — see CONTRIBUTING.md.

- The {Illustrated} Children’s Guide to
- Kubernetes

## p2 — credits

Brought to you by...

- Written by: Matt Butcher
- Illustrated by: Bailey Beougher
- Designed by: Karen Chu
- Illustration of Goldie is based on the Go Gopher designed by Renee French

> Phippy, Captain Kube, and The Children's Illustrated Guide to Kubernetes are copyright The Linux Foundation, on behalf of the Cloud Native Computing Foundation. They are licensed under Creative Commons Attribution 4.0 International (CC-BY-4.0). See phippy.io.

## p3 — dedication

Dedicated to all the parents who try to explain software engineering to their children.

## p4 — story: Phippy

Once upon a time, there was an app named Phippy. She was a simple app written in PHP and had just one page. She lived on a hosting provider and she shared her environment with scary other apps she didn't know, and didn't care to associate with. She wished she had her own environment; just her and a webserver she could call home.

## p5 — note: the environment

### The Environment

- The app itself
- Supporting structure
  - The Web Server
  - Various pieces of the OS

An app has an environment that it relies upon to run. For a PHP app, that environment might include a web server, a readable file system, and the PHP engine itself.

## p6 — story: the whale

One day, a kindly whale came along. He suggested that little Phippy might be happier living in a container and so she moved. The container was nice, but… it was a little bit like having a fancy living room floating in the middle of the ocean.

## p7 — note: containers

### Containers

- Need to be managed
- Networking is hard
- Containers must be scheduled, distributed, and load balanced
- And the data's got to persist *somewhere*

A container provides an isolated context in which an app, together with its environment, can run. But isolated containers often need to be managed and connected to the external world. Shared file systems, networking, scheduling, load balancing, and distribution are all challenges.

## p8 — story: Captain Kube

The whale shrugged his shoulders. "Sorry, kid," he said, and disappeared beneath the ocean's surface. But before Phippy could even begin to despair, a captain appeared on the horizon, piloting a gigantic ship. The ship was made of dozens of rafts all lashed together, but from the outside, it looked like one huge boat.

"Hello there, little app! My name is Captain Kube," said the wise old captain.

## p9 — note: Kubernetes

### Kubernetes

- Phi-Beta-Kappa: Philosophia Biou Kubernetes (Love of Wisdom Pilots life)

"Kubernetes" is the Greek word for a ship's captain. The words *Cybernetic* and *Gubernatorial* are derived from "Kubernetes". The Kubernetes project focuses on building a robust platform for running thousands of containers in production.

## p10 — story: the name tag

"I'm Phippy," said the little app.

"Nice to make your acquaintance," said the Captain as he gave her a name tag.

## p11 — note: labels

### Kubernetes Uses Labels

- Can query based on these labels

Kubernetes uses labels as "nametags" to identify things. Labels are open-ended. You can use them to indicate roles, stability, or other important attributes.

## p12 — story: the pod

Captain Kube suggested that the app might like to move her container to a pod on board the ship. Phippy happily moved her container aboard. It felt like home.

## p13 — note: pods

### Pods

- A pod can hold any number of containers, but usually only holds two
- We pretend one of those containers doesn't exist
- A pod is connected via an overlay network to the rest of the environment

A pod represents a runnable unit of work. Usually, a single container runs inside of a pod. But for cases where a few containers are tightly coupled, you may opt to run more than one container inside of the same Pod. Kubernetes takes on the work of connecting your pod to the network and the rest of the Kubernetes environment.

## p14 — story: cloning

Phippy had some unusual interests — she was really into genetics and sheep. And so she asked the captain, "What if I want to clone myself… On demand… Any number of times?"

"That's easy," said the captain as he introduced her to ReplicaSets.

## p15 — note: ReplicaSets

### ReplicaSets

- Have a *pod template* for creating any number of pod copies
- Provide logic for scaling the pod up or down
- Can be used for rolling deploys

ReplicaSets provide a method for managing an arbitrary number of pods. A ReplicaSet contains a pod template, which can be replicated any number of times. Through the ReplicaSet, Kubernetes will manage your pods' lifecycle, including scaling up and down, rolling deployments, and monitoring.

## p16 — story: the tunnel

For many days and nights, the little app was happy with her pod and happy with her replicas. But only having yourself for company is not all it's cracked up to be… even if there are N copies of yourself.

Captain Kube smiled benevolently, "I have just the thing."

No sooner had he spoken than a tunnel opened between Phippy's replication controller and the rest of the ship. With a hearty laugh, Captain Kube said, "Even when your clones come and go, this tunnel will stay here so you can discover other pods, and they can discover you!"

## p17 — note: services

### Services

- Persistent
- Provide discovery
- Provide load balancing
- Provide stable service address
- Find pods by label selector

A service tells the rest of the Kubernetes environment (including other pods and ReplicaSets) what services your application provides. While pods come and go, the service IP addresses and ports remain the same. Other applications can find your service through Kubernetes service discovery.

## p18 — story: Goldie's present

Phippy began to explore the rest of the ship. It wasn't long before Phippy met Goldie and they became the best of friends. One day, Goldie did something extraordinary. She gave Phippy a present. Phippy took one look and the saddest of sad tears escaped her eye.

"Why are you so sad?" asked Goldie.

"I love the present, but I have nowhere to put it!" sniffled Phippy.

But Goldie knew what to do, "Why not put it in a volume?"

## p19 — note: volumes

### Volumes

- Providers expose both persistent and ephemeral storage
  - Cloud Block Storage
  - Ceph
  - Gluster…
- Pods can mount volumes like filesystems

A volume represents a location where containers can access and store information. The volume appears as part of the local filesystem. Volumes may be backed by local storage, Ceph, Gluster, cloud block storage, or a number of other storage backends.

## p20 — story: privacy

Phippy loved life aboard Captain Kube's ship and she enjoyed the company of her new friends (every replicated pod of Goldie was equally delightful). But as she thought back to her days on the scary hosted provider, she began to wonder if perhaps she could also have a little privacy.

"It sounds like what you need," said Captain Kube, "is a namespace."

## p21 — note: namespaces

### Namespaces

- Group + segment pods, ReplicaSets, volumes, & secrets from each other

A namespace functions as a grouping mechanism inside of Kubernetes. Services, pods, ReplicaSets, and volumes can easily cooperate within a namespace, and the namespace provides a degree of isolation from other parts of the cluster.

## p22 — story: happily ever after

Life was good aboard Captain Kube's boat. Together with her new friends, Phippy sailed the seas. She had many grand adventures, but most importantly, Phippy had found her home.

And so Phippy lived happily ever after.

## p23 — back cover

The Illustrated Children's Guide to Kubernetes

Copyright The Linux Foundation on behalf of the Cloud Native Computing Foundation, licensed CC-BY-4.0.

phippy.io
