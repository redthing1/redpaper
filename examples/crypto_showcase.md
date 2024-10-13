---
title: "Cryptographic Algorithms and Techniques: A Typographical Showcase"
author: Claude 3.5 Sonnet
---

# Symmetric Encryption Algorithms

This section explores various symmetric encryption algorithms, showcasing their formal definitions and key characteristics.

## AES (Advanced Encryption Standard)

AES is a widely-adopted block cipher standardized by NIST. It operates on fixed-size blocks of 128 bits and supports key sizes of 128, 192, or 256 bits.

## Formal Definition

[$\text{Gen}()$]{.underline}:

1. Choose a key length $l \in \{128, 192, 256\}$
2. Generate a random bit string $k \in \{0,1\}^l$
3. Return $k$

[$\text{Enc}(k, m)$]{.underline}:

1. Parse $m$ as $(m_1, \ldots, m_n)$, where each $m_i$ is a 128-bit block
2. For $i = 1$ to $n$:
   - $c_i \leftarrow \text{AES}_k(m_i)$
3. Return $c = (c_1, \ldots, c_n)$

[$\text{Dec}(k, c)$]{.underline}:

1. Parse $c$ as $(c_1, \ldots, c_n)$, where each $c_i$ is a 128-bit block
2. For $i = 1$ to $n$:
   - $m_i \leftarrow \text{AES}_k^{-1}(c_i)$
3. Return $m = (m_1, \ldots, m_n)$

## ChaCha20

ChaCha20 is a stream cipher designed for high performance and strong security, operating on 512-bit blocks with a 256-bit key.

## Formal Definition

[$\text{Gen}()$]{.underline}:

1. Generate a random 256-bit key $k \in \{0,1\}^{256}$
2. Return $k$

[$\text{Enc}(k, m, \text{nonce})$]{.underline}:

1. Initialize the ChaCha20 state with $k$ and $\text{nonce}$
2. Generate a keystream $ks$ of length $|m|$
3. Compute $c \leftarrow m \oplus ks$
4. Return $c$

[$\text{Dec}(k, c, \text{nonce})$]{.underline}:

1. Initialize the ChaCha20 state with $k$ and $\text{nonce}$
2. Generate a keystream $ks$ of length $|c|$
3. Compute $m \leftarrow c \oplus ks$
4. Return $m$

## Mono-Alphabetic Substitution Cipher

A simple cipher that replaces each letter in the plaintext with another fixed letter.

## Formal Definition

[$\text{Gen}()$]{.underline}:

1. Generate a random permutation $\pi$ of the 26-letter English alphabet $\{A,\ldots,Z\}$
2. Return $\pi$

[$\text{Enc}(\pi, m)$]{.underline}:

1. Parse $m$ as $(m_1, \ldots, m_\ell) \in \{A,\ldots,Z\}^\ell$
2. For $i = 1$ to $\ell$:
   - $c_i \leftarrow \pi(m_i)$
3. Return $c = (c_1, \ldots, c_\ell)$

[$\text{Dec}(\pi, c)$]{.underline}:

1. Parse $c$ as $(c_1, \ldots, c_\ell) \in \{A,\ldots,Z\}^\ell$
2. Compute $\pi^{-1}$, the inverse permutation of $\pi$
3. For $i = 1$ to $\ell$:
   - $m_i \leftarrow \pi^{-1}(c_i)$
4. Return $m = (m_1, \ldots, m_\ell)$

# Asymmetric Encryption Algorithms

Asymmetric encryption algorithms use a pair of keys: a public key for encryption and a private key for decryption.

## RSA (Rivest-Shamir-Adleman)

RSA is one of the first public-key cryptosystems and is widely used for secure data transmission.

## Formal Definition

[$\text{Gen}()$]{.underline}:

1. Select two distinct large prime numbers $p$ and $q$
2. Compute $n \leftarrow p \times q$
3. Compute $\phi(n) \leftarrow (p-1)(q-1)$
4. Choose an integer $e$ such that $1 < e < \phi(n)$ and $\gcd(e, \phi(n)) = 1$
5. Compute $d \leftarrow e^{-1} \mod \phi(n)$
6. Return public key $(n, e)$ and private key $(n, d)$

[$\text{Enc}((n, e), m)$]{.underline}:

1. Compute $c \leftarrow m^e \mod n$
2. Return $c$

[$\text{Dec}((n, d), c)$]{.underline}:

1. Compute $m \leftarrow c^d \mod n$
2. Return $m$

## Elliptic Curve Cryptography (ECC)

ECC is based on the algebraic structure of elliptic curves over finite fields, offering similar security to RSA with smaller key sizes.

## Formal Definition

[$\text{Gen}()$]{.underline}:

1. Choose an elliptic curve $E$ over a finite field $\mathbb{F}_p$ defined by $y^2 = x^3 + ax + b$
2. Select a base point $G \in E(\mathbb{F}_p)$ of large prime order $n$
3. Choose a random integer $d \in [1, n-1]$
4. Compute $Q \leftarrow dG$
5. Return public key $Q$ and private key $d$

[$\text{Enc}(Q, m)$]{.underline}:

1. Choose a random integer $k \in [1, n-1]$
2. Compute $C_1 \leftarrow kG$
3. Compute $C_2 \leftarrow m + kQ$
4. Return ciphertext $(C_1, C_2)$

[$\text{Dec}(d, (C_1, C_2))$]{.underline}:

1. Compute $m \leftarrow C_2 - dC_1$
2. Return $m$

# Cryptanalysis Techniques

Cryptanalysis involves studying cryptographic algorithms to find weaknesses or develop methods to break them without knowledge of the secret key.

## Frequency Analysis

Frequency analysis exploits the non-uniform frequency distribution of letters in natural languages to break classical ciphers.

## Methodology

Let $f_i$ be the frequency of the $i$-th letter in the ciphertext, and $p_i$ be the expected frequency in the plaintext language. The **Index of Coincidence (IC)** is defined as:

$$ IC = \sum_{i=1}^{26} f_i \cdot p_i $$

For English text, $IC \approx 0.065$. Deviations from this value may indicate the use of polyalphabetic ciphers like the Vigenère cipher.

## Linear Cryptanalysis

Linear cryptanalysis is a method of exploiting linear approximations to describe the behavior of the block cipher.

## Formal Definition

For a block cipher with $n$-bit plaintext $P$, $n$-bit ciphertext $C$, and key $K$, linear cryptanalysis seeks linear expressions involving bits of $P$, $C$, and $K$ such that:

$$ \Pr\left(\bigoplus_{i \in \alpha} P_i \oplus \bigoplus_{j \in \beta} C_j = \bigoplus_{k \in \gamma} K_k\right) \approx 0.5 + \epsilon $$

Where:
- $\alpha$, $\beta$, and $\gamma$ are subsets of bit positions.
- $\epsilon$ is a non-zero bias that the attacker exploits.

**Linear Probability:**

$$ LP = \left| \Pr\left(\bigoplus_{i \in \alpha} P_i \oplus \bigoplus_{j \in \beta} C_j = 0 \right) - \frac{1}{2} \right| $$

A higher $LP$ indicates a stronger correlation that can be exploited to recover the key bits.

# Modern Cryptographic Primitives

Modern cryptography encompasses a variety of primitives that serve as building blocks for secure communication systems.

## Hash Functions

Hash functions map data of arbitrary size to fixed-size values, ensuring properties like preimage resistance and collision resistance.

## SHA-256

SHA-256 is a member of the SHA-2 family, producing a 256-bit hash value.

$$ \text{SHA-256}(m) \rightarrow h \in \{0,1\}^{256} $$

## Digital Signatures

Digital signatures provide a method for verifying the authenticity and integrity of messages.

## ECDSA (Elliptic Curve Digital Signature Algorithm)

[$\text{Sign}(d, m)$]{.underline}:

1. Choose a random integer $k \in [1, n-1]$
2. Compute $R \leftarrow kG$
3. Compute $r \leftarrow R_x \mod n$
4. Compute $s \leftarrow k^{-1}(H(m) + dr) \mod n$
5. Return signature $(r, s)$

[$\text{Verify}(Q, m, (r, s))$]{.underline}:

1. Compute $w \leftarrow s^{-1} \mod n$
2. Compute $u_1 \leftarrow H(m) \cdot w \mod n$
3. Compute $u_2 \leftarrow r \cdot w \mod n$
4. Compute $R' \leftarrow u_1 G + u_2 Q$
5. If $R'_x \mod n = r$, accept the signature; otherwise, reject

# Cryptographic Protocols

Cryptographic protocols define the rules and procedures for secure communication between parties.

## Diffie-Hellman Key Exchange

The Diffie-Hellman protocol allows two parties to establish a shared secret over an insecure channel.

## Protocol Steps

a) **Parameter Agreement:** Agree on a large prime $p$ and base $g$ such that $g$ is a primitive root modulo $p$.
b) **Key Generation:**
   - Alice selects a secret integer $a \in [1, p-2]$ and computes $A = g^a \mod p$.
   - Bob selects a secret integer $b \in [1, p-2]$ and computes $B = g^b \mod p$.
c) **Public Exchange:** Alice sends $A$ to Bob, and Bob sends $B$ to Alice.
d) **Shared Secret Computation:**
   - Alice computes $s = B^a \mod p$.
   - Bob computes $s = A^b \mod p$.
e) **Result:** Both parties now share the secret $s$, which can be used as a symmetric key for further encrypted communication.

## TLS (Transport Layer Security)

TLS is a widely-used protocol that ensures privacy and data integrity between two communicating applications.

## Handshake Process

a) **Client Hello:** The client sends a "Client Hello" message with supported cipher suites and a random nonce.
b) **Server Hello:** The server responds with a "Server Hello" message, selecting the cipher suite and sending its own random nonce.
c) **Certificate Exchange:** The server sends its digital certificate containing its public key.
d) **Key Exchange:** Both parties perform a key exchange (e.g., Diffie-Hellman) to establish a shared secret.
e) **Finished Messages:** Both client and server send encrypted "Finished" messages to confirm the handshake.
f) **Secure Communication:** Encrypted communication begins using the established symmetric keys.

# Cryptographic Attacks

Understanding potential attacks is crucial for designing robust cryptographic systems.

## Chosen-Plaintext Attack (CPA)

In a CPA, the attacker can choose arbitrary plaintexts to be encrypted and obtain the corresponding ciphertexts, aiming to uncover the encryption key or plaintexts of other ciphertexts.

## Breaking Classical Ciphers under CPA

**Shift Cipher**

Required Plaintext: 1 character.

Attack Steps:
1. Choose plaintext $P = \text{"A"}$.
2. Obtain ciphertext $C = \text{Enc}(k, P)$.
3. Compute the shift as $k = C - P$ (mod 26).

**Substitution Cipher**

Required Plaintext: 26 unique characters (the entire alphabet).

Attack Steps:
1. Choose plaintext $P = \text{"ABCDEFGHIJKLMNOPQRSTUVWXYZ"}$.
2. Obtain ciphertext $C = \text{Enc}(\pi, P)$.
3. Deduce the permutation $\pi$ by mapping each $P_i$ to $C_i$.

**Vigenère Cipher**

Required Plaintext: $b \cdot n$ characters, where $n$ is the key length and $b$ is a small integer.

Attack Steps:
1. Choose plaintext $P = \text{"AAAA\ldots"}$ (repeating "A").
2. Obtain ciphertext $C = \text{Enc}(k, P)$.
3. Use the Index of Coincidence to determine the key length $n$.
4. Perform frequency analysis on each $n$-th character to deduce the key.

## Known-Plaintext Attack (KPA)

In a KPA, the attacker has access to some pairs of plaintexts and their corresponding ciphertexts, which can be used to deduce the encryption key or decrypt other ciphertexts.

## Attack on RSA

**Factorization Attack**

If an attacker can factorize the RSA modulus $n = pq$ into its prime factors $p$ and $q$, they can compute $\phi(n)$ and subsequently the private key $d$.

**Common Modulus Attack**

If the same modulus $n$ is used with different public exponents $e_1$ and $e_2$, and an attacker has ciphertexts encrypted with both exponents for the same plaintext, they can potentially recover the plaintext using the Extended Euclidean Algorithm.

# Advanced Topics

## Quantum Cryptography

Quantum cryptography leverages principles of quantum mechanics to achieve secure communication.

## Quantum Key Distribution (QKD)

QKD allows two parties to generate a shared random secret key, which can then be used for secure communication. The most well-known QKD protocol is BB84.

**BB84 Protocol Steps:**
1. **Preparation:** Alice prepares a sequence of qubits in one of four possible polarization states.
2. **Transmission:** Alice sends the qubits to Bob over a quantum channel.
3. **Measurement:** Bob randomly chooses a measurement basis (rectilinear or diagonal) for each qubit and measures them.
4. **Basis Reconciliation:** Alice and Bob publicly compare their chosen bases and keep only the measurements where their bases matched.
5. **Key Sifting:** The resulting bit string is processed to generate the shared secret key.

## Post-Quantum Cryptography

With the advent of quantum computing, traditional cryptographic algorithms like RSA and ECC are vulnerable. Post-quantum cryptography aims to develop secure algorithms resistant to quantum attacks.

## Lattice-Based Cryptography

Lattice-based schemes rely on the hardness of lattice problems, such as the Shortest Vector Problem (SVP) and Learning With Errors (LWE).

**Example: Learning With Errors (LWE)**

$$ A \in \mathbb{Z}_q^{m \times n}, \quad s \in \mathbb{Z}_q^n, \quad e \in \mathbb{Z}_q^m $$

The LWE problem involves solving for $s$ given pairs $(A, b)$ where $b = A s + e \mod q$, and $e$ is an error vector with small entries.

# Conclusion

This document has provided a comprehensive overview of various cryptographic algorithms, protocols, and cryptanalysis techniques, all while showcasing the typographical strengths of the LaTeX typesetting system. From classical ciphers like the shift and substitution ciphers to modern asymmetric algorithms like RSA and ECC, as well as advanced topics in quantum and post-quantum cryptography, the document illustrates the diverse landscape of cryptography through well-structured sections, formal definitions, and mathematical notation.