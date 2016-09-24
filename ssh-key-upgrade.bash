#!/bin/bash
cd
for keyfile in ~/.ssh/id_*; do ssh-keygen -l -f "${keyfile}"; done | uniq > ~/ssh-key-security-status
# DSA or RSA 1024 bits: red flag. Unsafe.
#RSA 2048: yellow recommended to change
#RSA 3072/4096: great, but Ed25519 has some benefits!
#ECDSA: depends. Recommended to change
#Ed25519: wow cool, but are you brute-force safe?
rm -rf ~/.ssh
ssh-keygen -o -a 100 -t ed25519
for keyfile in ~/.ssh/id_*; do ssh-keygen -l -f "${keyfile}"; done | uniq
