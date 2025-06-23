# TP 1

## Part I : Init

### I : Installation de Docker

> Passée car déjà installé

### II : Un premier conteneur en vif

#### 1. Simple Run

##### Lancer un conteneur `meow-api` :

```
> docker run -p 8000:8000 it4lik/meow-api:arm
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://172.17.0.2:8000
Press CTRL+C to quit
```

##### Visitons

- vérifier que le conteneur est actif avec une commande qui liste les conteneurs en cours de fonctionnement
```
> docker ps
CONTAINER ID   IMAGE                 COMMAND           CREATED         STATUS         PORTS                    NAMES
66fc6b8bd9cd   it4lik/meow-api:arm   "python app.py"   3 seconds ago   Up 3 seconds   0.0.0.0:8000->8000/tcp   modest_goodall
```
- afficher les logs du conteneur
```
docker logs 66fc6b8bd9cd
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://172.17.0.2:8000
Press CTRL+C to quit
```
- afficher toutes les informations relatives au conteneur avec une commande docker inspect
[```docker inspect 66fc6b8bd9cd```](#la-commande-docker-inspect-66fc6b8bd9cd-et-son-output)
- depuis le navigateur de votre PC, visiter la route / de l'API sur http://votre_ip:8000
[```http://127.0.0.1:800/```](http://127.0.0.1:800/)

##### Lancer le conteneur en tâche de fond

- ajoutez `-d` à la commande
```
docker run -d -p 8000:8000 it4lik/meow-api:arm
66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f
```

- consultez les logs du conteneur
```
docker logs 66fc6b8bd9cd
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://172.17.0.2:8000
Press CTRL+C to quit
172.17.0.1 - - [23/Jun/2025 08:26:29] "GET / HTTP/1.1" 200 -
```

#### 2. Volumes

##### Remplacer le code de `app.py`
```
docker run -d -v "$(pwd)/app.py:/app/app.py" -p 8000:8000 it4lik/meow-api:arm
2e53ba08b35c4c4f05e32afb9a442dec817f1e405f0f81cd2107becc969d7a67
```

##### Prouvez que ça fonctionne avec une requête Web
```
curl http://127.0.0.1:8000
{"message":"Le curl fonctionne chef !"}
```

#### 3. Variables d'environnement

##### Définir une variable d'environnement au lancement du conteneur / Mettez à jour l'option `-p`
```
docker run -d -v "$(pwd)/app.py:/app/app.py" -e LISTEN_PORT=16789 -p 16789:16789 it4lik/meow-api:arm
2e0df2d1018426fe0a5569b28544f9f8f3501a86fd2e5ff10c449872ef4eda37
```

##### Prouvez que ça fonctionne avec une requête Web
```
curl http://127.0.0.1:16789
{"listen_port":"16789","message":"Le curl fonctionne chef !"}
```

## Part II : Images

### I. Images publiques

#### Récupérez des images publiques
- Python
```
docker pull python:latest
latest: Pulling from library/python
Digest: sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b
Status: Downloaded newer image for python:latest
docker.io/library/python:latest
```
- MySQL
```
docker pull mysql:latest
latest: Pulling from library/mysql
b874233f830c: Download complete
147b5c0a118e: Download complete
00735954ac4b: Download complete
ca07bba4ff38: Download complete
12d652dc2508: Download complete
cffd736c905d: Download complete
a71c45291463: Download complete
65a492f1b8dd: Download complete
a8868fca330e: Download complete
1281dea9bbdc: Download complete
Digest: sha256:072f96c2f1ebb13f712fd88d0ef98f2ef9a52ad4163ae67b550ed6720b6d642e
Status: Downloaded newer image for mysql:latest
docker.io/library/mysql:latest
```
- Wordpress
```
docker pull wordpress:latest
latest: Pulling from library/wordpress
34ef2a75627f: Download complete
68dcd2860c81: Download complete
24fdd0d074fa: Download complete
c2a5deda81d7: Download complete
3328044d89bc: Download complete
afd2e054d8d1: Download complete
0c3f64a2b782: Download complete
e5986a134440: Download complete
5ba2a3743b4b: Download complete
39acdc354785: Download complete
3fff45d01fc3: Download complete
877a4d3e37c3: Download complete
f79b6cf338f4: Download complete
b29695fa5193: Download complete
cbda9f6cd672: Download complete
3630c4a6bfab: Download complete
a543208f4efc: Download complete
a25063be4912: Download complete
4f4fb700ef54: Already exists
f8dd604a657c: Download complete
211625f3b9f3: Download complete
02c79cd8699c: Download complete
Digest: sha256:1931132b0b93230ee44d9628868e3ffe2076f49ba6569b36d281c0ccaa618ef4
Status: Downloaded newer image for wordpress:latest
docker.io/library/wordpress:latest
```
- linuxserver/wikijs
```
docker pull linuxserver/wikijs:latest
latest: Pulling from linuxserver/wikijs
b099656749ad: Download complete
bc92fab8947f: Download complete
e1cde46db0e1: Download complete
8423e39ae289: Download complete
e7e33b357221: Download complete
1bfc3bc05ba0: Download complete
33fedb35122c: Download complete
8e2f36998bea: Download complete
0c12cf8e3fe6: Download complete
Digest: sha256:f997a921b7695fc7528740ad2c36c10b0b9c23b2878a937487367ad98df15591
Status: Downloaded newer image for linuxserver/wikijs:latest
docker.io/linuxserver/wikijs:latest
```
- Listez les images que vous avez sur la machine avec une commande `docker`
```
docker images
REPOSITORY                                                  TAG                      IMAGE ID       CREATED        SIZE
it4lik/meow-api                                             arm                      aa62b5955aa8   2 hours ago    1.62GB
<none>                                                      <none>                   83ea4c39325a   2 hours ago    1.62GB
it4lik/meow-api                                             latest                   51264a230802   6 days ago     1.47GB
linuxserver/wikijs                                          latest                   f997a921b769   9 days ago     788MB
python                                                      latest                   5f69d22a88dd   11 days ago    1.47GB
gcr.io/k8s-minikube/kicbase                                 v0.0.47                  631837ba851f   4 weeks ago    1.76GB
gcr.io/k8s-minikube/kicbase                                 <none>                   6ed579c9292b   4 weeks ago    1.76GB
wordpress                                                   latest                   1931132b0b93   7 weeks ago    985MB
mysql                                                       latest                   072f96c2f1eb   2 months ago   1.19GB
<none>                                                      <none>                   0c613ca328ba   3 months ago   1.94GB
<none>                                                      <none>                   4fb0f172e653   3 months ago   1.94GB
<none>                                                      <none>                   880518d06ffb   3 months ago   1.94GB
<none>                                                      <none>                   913c740a2840   3 months ago   1.94GB
<none>                                                      <none>                   bb2c4794e5a2   3 months ago   1.95GB
bookwormpython3amd                                          latest                   0cc90cd79af6   4 months ago   438MB
bookwormpython3arm                                          latest                   31ac034876c1   4 months ago   460MB
<none>                                                      <none>                   645c7b1b6744   4 months ago   460MB
bookwormpython3                                             latest                   43ec98764c55   4 months ago   460MB
326954429656.dkr.ecr.eu-west-1.amazonaws.com/node-runtime   20-bookworm-slim-arm64   13cdbc9b5967   4 months ago   413MB
326954429656.dkr.ecr.eu-west-1.amazonaws.com/backstage      prod                     e3303916085b   55 years ago   415MB    
```

#### Lancer un conteneur à partir de l'image python
- Lancez un terminal `bash` ou `sh` à l'intérieur du conteneur
```
docker run -it python bash
root@13020aa109c3:/#
```
- Vérifiez que la commande `python` est installée dans le conteneur, à la bonne version
```
docker run -it python bash
root@4c45ece8c66e:/# python -V
Python 3.13.5
root@4c45ece8c66e:/#
```

### II. Construire une image

#### A. Build la meow-api
- Écrire le [Dockerfile](./Dockerfile-A)

- Build une image meow-api
```
docker build . -t meow-api
[+] Building 6.9s (11/11) FINISHED                                                                                                                                    docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                  0.0s
 => => transferring dockerfile: 559B                                                                                                                                                  0.0s
 => [internal] load metadata for docker.io/library/python:3                                                                                                                           1.0s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                                                         0.0s
 => [internal] load .dockerignore                                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                                       0.0s
 => [1/5] FROM docker.io/library/python:3@sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b                                                                     0.0s
 => => resolve docker.io/library/python:3@sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b                                                                     0.0s
 => [internal] load build context                                                                                                                                                     0.0s
 => => transferring context: 102B                                                                                                                                                     0.0s
 => [2/5] WORKDIR /app                                                                                                                                                                0.0s
 => [3/5] COPY ./requirements.txt .                                                                                                                                                   0.0s
 => [4/5] RUN pip install --no-cache-dir -r requirements.txt                                                                                                                          3.4s
 => [5/5] COPY ./app.py .                                                                                                                                                             0.0s
 => exporting to image                                                                                                                                                                2.3s
 => => exporting layers                                                                                                                                                               1.9s
 => => exporting manifest sha256:0ae5eb7a624362a347303de3ccc69a6c7c8518d71c6acbbbd46208bdc7dcc2a3                                                                                     0.0s
 => => exporting config sha256:61dd583919c6fa94c3a1533a0eb25da3a8adc5f2e6976dbbbbe06487efbddcd6                                                                                       0.0s
 => => exporting attestation manifest sha256:ab786dfacb0324f0382753596f53db892cfb67f5e7efd5b1c3e8e3317abba63b                                                                         0.0s
 => => exporting manifest list sha256:af5e20b7399046e80cd2e6412f74963e0db5ef8fbffc4724e4fc146a5d08242b                                                                                0.0s
 => => naming to docker.io/library/meow-api:latest                                                                                                                                    0.0s
 => => unpacking to docker.io/library/meow-api:latest                                                                                                                                 0.4s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/6kpg1be79vdghyrlf60w9wlqa

```
- Afficher la liste des images dispos sur votre machine
```
docker images
REPOSITORY                                                  TAG                      IMAGE ID       CREATED          SIZE
meow-api                                                    latest                   af5e20b73990   19 seconds ago   1.62GB
```
- Run cette image
```
docker run meow-api
Fichier app.py overridé !
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8000
 * Running on http://172.17.0.3:8000
Press CTRL+C to quit
```
#### B. Packagez vous-même une app
- Écrire le [Dockerfile](./Dockerfile-B)

- Build l'image
```
docker build . -t my-app
[+] Building 0.7s (10/10) FINISHED                                                                                                                                    docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                  0.0s
 => => transferring dockerfile: 561B                                                                                                                                                  0.0s
 => [internal] load metadata for docker.io/library/python:3                                                                                                                           0.5s
 => [internal] load .dockerignore                                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                                       0.0s
 => [1/5] FROM docker.io/library/python:3@sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b                                                                     0.0s
 => => resolve docker.io/library/python:3@sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b                                                                     0.0s
 => [internal] load build context                                                                                                                                                     0.0s
 => => transferring context: 63B                                                                                                                                                      0.0s
 => CACHED [2/5] WORKDIR /app                                                                                                                                                         0.0s
 => CACHED [3/5] COPY ./requirements.txt .                                                                                                                                            0.0s
 => CACHED [4/5] RUN pip install --no-cache-dir -r requirements.txt                                                                                                                   0.0s
 => CACHED [5/5] COPY ./app2.py .                                                                                                                                                     0.0s
 => exporting to image                                                                                                                                                                0.0s
 => => exporting layers                                                                                                                                                               0.0s
 => => exporting manifest sha256:8bd05b4da47e340d5416b2b3def199a33819bd04f36e7fffceb9ba61eb412334                                                                                     0.0s
 => => exporting config sha256:1cbdbdc0794dec5465e3aea2fe45d7862c2b6893400432f770dd59b807543f7a                                                                                       0.0s
 => => exporting attestation manifest sha256:20e715d46f1116b439394099325cad40acd1e7ee2c0e52a70f981baf7b45156c                                                                         0.0s
 => => exporting manifest list sha256:b478bf885c6ed0102c9ecfde02430b8a1d134c723220e3cbe316dcf433c2655a                                                                                0.0s
 => => naming to docker.io/library/my-app:latest                                                                                                                                      0.0s
 => => unpacking to docker.io/library/my-app:latest                                                                                                                                   0.0s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/kl0o3jp0bk4o57tqqvjczaloy
```

- Proof !
```
docker images
REPOSITORY                                                  TAG                      IMAGE ID       CREATED          SIZE
my-app                                                      latest                   7c68dc20b92c   3 minutes ago    1.63GB
```

- Lancer l'image
```
docker run my-app
Cet exemple d'application est vraiment naze 👎
```

#### C. Écrire votre propre Dockerfile

- Télécharger l'image de base
```
docker pull jitesoft/node-yarn
Using default tag: latest
latest: Pulling from jitesoft/node-yarn
7ee5168d030b: Download complete
4c63ef11adbd: Download complete
16c79c2d58ae: Download complete
94e9d8af2201: Download complete
Digest: sha256:19eb9470922333d4b2a449fb3a78a6c80944306e5186d73ea08362a47b073a8a
Status: Downloaded newer image for jitesoft/node-yarn:latest
docker.io/jitesoft/node-yarn:latest
```

- Générer un mini front Vue
- Modifier vite.config.ts pour faire en sorte de listen sur tout les IPs de conteneur
```
import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  server: {
    // This is where you configure the dev server
    host: '0.0.0.0', // Listen on all network interfaces
    port: 5173       // You can also change the default port
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
  },
})

```

- Écrire le [Dockerfile](./Dockerfile)

- Build le Dockerfile
```
docker build . -t teo1403/small-front
[+] Building 24.8s (11/11) FINISHED                                                                                                                                   docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                  0.0s
 => => transferring dockerfile: 155B                                                                                                                                                  0.0s
 => [internal] load metadata for docker.io/jitesoft/node-yarn:latest                                                                                                                  0.0s
 => [internal] load .dockerignore                                                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                                                       0.0s
 => [1/5] FROM docker.io/jitesoft/node-yarn:latest@sha256:19eb9470922333d4b2a449fb3a78a6c80944306e5186d73ea08362a47b073a8a                                                            1.0s
 => => resolve docker.io/jitesoft/node-yarn:latest@sha256:19eb9470922333d4b2a449fb3a78a6c80944306e5186d73ea08362a47b073a8a                                                            1.0s
 => [internal] load build context                                                                                                                                                     0.2s
 => => transferring context: 562.48kB                                                                                                                                                 0.2s
 => [auth] jitesoft/node-yarn:pull token for registry-1.docker.io                                                                                                                     0.0s
 => CACHED [2/5] WORKDIR /app                                                                                                                                                         0.0s
 => [3/5] COPY ./small-front/. .                                                                                                                                                      0.4s
 => [4/5] RUN yarn install                                                                                                                                                            7.5s
 => [5/5] RUN yarn format                                                                                                                                                             0.5s
 => exporting to image                                                                                                                                                               15.0s
 => => exporting layers                                                                                                                                                              12.2s
 => => exporting manifest sha256:61a7f701f1ae5f3c6e78dfe77d4e371c1978ed997a742d05bc6d7333a744007a                                                                                     0.0s
 => => exporting config sha256:bc128d42d1e3b717841cae29c43b7e9b044f6e4bdebd0bcd016c758d796e813e                                                                                       0.0s
 => => exporting attestation manifest sha256:c62b1dd3b4a7c2ad630644527a5db43dff069e1759036c7c504d920e1812334d                                                                         0.0s
 => => exporting manifest list sha256:dba05273a825697a7b088f9fc02b24342e97c3c1122530472be08f8037f663f6                                                                                0.0s
 => => naming to docker.io/teo1403/small-front:latest                                                                                                                                 0.0s
 => => unpacking to docker.io/teo1403/small-front:latest                                                                                                                              2.8s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/nhlt51gyolhlam9wff7tzhk2v
```
- Run le Dockerfile
```
docker run -p 5173:5173 teo1403/small-front
yarn run v1.22.22
$ vite
12:38:46 PM [vite] (client) Re-optimizing dependencies because lockfile has changed

  VITE v6.3.5  ready in 356 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: http://172.17.0.2:5173/
  ➜  Vue DevTools: Open http://localhost:5173/__devtools__/ as a separate window
  ➜  Vue DevTools: Press Alt(⌥)+Shift(⇧)+D in App to toggle the Vue DevTools

```

- Ouvrir l'[URL](http://localhost:5173/)
- [URL Dockerhub de l'image](https://hub.docker.com/r/teo1403/small-front)
- Profit $$$

## Part III : Compose

### Getting Started

#### 1. Run it

- Créez un fichier [`docker-compose.yml`](./compose_test/docker-compose.yml)
- Lancez les deux conteneurs avec `docker compose`
```
docker compose up -d
WARN[0000] /Users/teo.ladouche/School/docker-avance/docker-avance/tp1/compose_test/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
[+] Running 2/2
 ✔ conteneur_nul Pulled                                                                                                                                                               2.4s
 ✔ conteneur_flopesque Pulled                                                                                                                                                         2.4s
[+] Running 3/3
 ✔ Network compose_test_default                  Created                                                                                                                              0.0s
 ✔ Container compose_test-conteneur_flopesque-1  Started                                                                                                                              0.2s
 ✔ Container compose_test-conteneur_nul-1        Started
```
- Vérifie que les deux conteneurs tournent
```
docker compose ps
WARN[0000] /Users/teo.ladouche/School/docker-avance/docker-avance/tp1/compose_test/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
NAME                                 IMAGE     COMMAND        SERVICE               CREATED              STATUS              PORTS
compose_test-conteneur_flopesque-1   debian    "sleep 9999"   conteneur_flopesque   About a minute ago   Up About a minute
compose_test-conteneur_nul-1         debian    "sleep 9999"   conteneur_nul         About a minute ago   Up About a minute
```

#### 2. What about networking

- Pop un shell dans le conteneur `conteneur_nul`
```
docker exec -it compose_test-conteneur_nul-1 bash
root@4d73da2cfb6c:/#
```

- Installation de `ping`
```
docker exec -it compose_test-conteneur_nul-1 bash
root@4d73da2cfb6c:/# apt-get update -y
Get:1 http://deb.debian.org/debian bookworm InRelease [151 kB]
Get:2 http://deb.debian.org/debian bookworm-updates InRelease [55.4 kB]
Get:3 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]
Get:4 http://deb.debian.org/debian bookworm/main arm64 Packages [8693 kB]
Get:5 http://deb.debian.org/debian bookworm-updates/main arm64 Packages [756 B]
Get:6 http://deb.debian.org/debian-security bookworm-security/main arm64 Packages [264 kB]
Fetched 9213 kB in 1s (8347 kB/s)
Reading package lists... Done
root@4d73da2cfb6c:/# apt-get install -y iputils-ping
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libcap2-bin libpam-cap
The following NEW packages will be installed:
  iputils-ping libcap2-bin libpam-cap
0 upgraded, 3 newly installed, 0 to remove and 0 not upgraded.
Need to get 94.9 kB of archives.
After this operation, 598 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bookworm/main arm64 libcap2-bin arm64 1:2.66-4+deb12u1 [34.1 kB]
Get:2 http://deb.debian.org/debian bookworm/main arm64 iputils-ping arm64 3:20221126-1+deb12u1 [46.1 kB]
Get:3 http://deb.debian.org/debian bookworm/main arm64 libpam-cap arm64 1:2.66-4+deb12u1 [14.7 kB]
Fetched 94.9 kB in 0s (345 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libcap2-bin.
(Reading database ... 6083 files and directories currently installed.)
Preparing to unpack .../libcap2-bin_1%3a2.66-4+deb12u1_arm64.deb ...
Unpacking libcap2-bin (1:2.66-4+deb12u1) ...
Selecting previously unselected package iputils-ping.
Preparing to unpack .../iputils-ping_3%3a20221126-1+deb12u1_arm64.deb ...
Unpacking iputils-ping (3:20221126-1+deb12u1) ...
Selecting previously unselected package libpam-cap:arm64.
Preparing to unpack .../libpam-cap_1%3a2.66-4+deb12u1_arm64.deb ...
Unpacking libpam-cap:arm64 (1:2.66-4+deb12u1) ...
Setting up libcap2-bin (1:2.66-4+deb12u1) ...
Setting up libpam-cap:arm64 (1:2.66-4+deb12u1) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 78.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/aarch64-linux-gnu/perl/5.36.0 /usr/local/share/perl/5.36.0 /usr/lib/aarch64-linux-gnu/perl5/5.36 /usr/share/perl5 /usr/lib/aarch64-linux-gnu/perl-base /usr/lib/aarch64-linux-gnu/perl/5.36 /usr/share/perl/5.36 /usr/local/lib/site_perl) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Setting up iputils-ping (3:20221126-1+deb12u1) ...
```
- Ping `conteneur_flopesque`
```
root@4d73da2cfb6c:/# ping conteneur_flopesque
PING conteneur_flopesque (172.18.0.3) 56(84) bytes of data.
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=1 ttl=64 time=0.333 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=2 ttl=64 time=0.163 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=3 ttl=64 time=0.157 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=4 ttl=64 time=0.152 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=5 ttl=64 time=0.151 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=6 ttl=64 time=0.155 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=7 ttl=64 time=0.158 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=8 ttl=64 time=0.161 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=9 ttl=64 time=0.155 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=10 ttl=64 time=0.158 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=11 ttl=64 time=0.165 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=12 ttl=64 time=0.150 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=13 ttl=64 time=0.162 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=14 ttl=64 time=0.165 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=15 ttl=64 time=0.275 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=16 ttl=64 time=0.165 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=17 ttl=64 time=0.262 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=18 ttl=64 time=0.288 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=19 ttl=64 time=0.160 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=20 ttl=64 time=0.250 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=21 ttl=64 time=0.149 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=22 ttl=64 time=0.161 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=23 ttl=64 time=0.083 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=24 ttl=64 time=0.147 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=25 ttl=64 time=0.145 ms
64 bytes from compose_test-conteneur_flopesque-1.compose_test_default (172.18.0.3): icmp_seq=26 ttl=64 time=0.179 ms
```

6. Rendu attendu

- [`docker-compose.yml`](./meow_compose/docker-compose.yml)
- [`seed.sql`](./meow_compose/seed.sql)
- [`.env`](./meow_compose/.env)
- [`Dockerfile`](./meow_compose/Dockerfile)
- Un `docker compose up` qui fonctionne
```
docker compose up --build -d
WARN[0000] /Users/teo.ladouche/School/docker-avance/docker-avance/tp1/meow_compose/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
[+] Running 0/0
 ⠋ Service meow_compose  Building                                                                                                                                                     0.1s
[+] Building 0.7s (11/11) FINISHED                                                                                                                                    docker:desktop-linux
 => [meow_compose internal] load build definition from Dockerfile                                                                                                                     0.0s
 => => transferring dockerfile: 559B                                                                                                                                                  0.0s
 => [meow_compose internal] load metadata for docker.io/library/python:3                                                                                                              0.5s
 => [meow_compose internal] load .dockerignore                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                       0.0s
 => [meow_compose 1/5] FROM docker.io/library/python:3@sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b                                                        0.0s
 => => resolve docker.io/library/python:3@sha256:5f69d22a88dd4cc4ee1576def19aef48c8faa1b566054c44291183831cbad13b                                                                     0.0s
 => [meow_compose internal] load build context                                                                                                                                        0.0s
 => => transferring context: 63B                                                                                                                                                      0.0s
 => CACHED [meow_compose 2/5] WORKDIR /app                                                                                                                                            0.0s
 => CACHED [meow_compose 3/5] COPY ./requirements.txt .                                                                                                                               0.0s
 => CACHED [meow_compose 4/5] RUN pip install --no-cache-dir -r requirements.txt                                                                                                      0.0s
 => CACHED [meow_compose 5/5] COPY ./app.py .                                                                                                                                         0.0s
 => [meow_compose] exporting to image                                                                                                                                                 0.0s
 => => exporting layers                                                                                                                                                               0.0s
 => => exporting manifest sha256:b275a1a41a17ffc1b6fada242a944f7b8b676ba14784940fe889506d14db557c                                                                                     0.0s
 => => exporting config sha256:6ced8159b64097c539ff14beacf519cbd2fe88fcaeba58c7a0358ed96c02da82                                                                                       0.0s
 => => exporting attestation manifest sha256:10dcae34c83ca181cb060be7350dfa5e743fd79b850c9807d7ec7d5508c60fb2                                                                         0.0s
 => => exporting manifest list sha256:4447b5797d3b4d98d878d6660a0e36063d9417a4e409301703a0b0a5721cee5e                                                                                0.0s
 => => naming to docker.io/library/meow-compose:latest                                                                                                                                0.0s
[+] Running 4/4g to docker.io/library/meow-compose:latest                                                                                                                             0.0s
 ✔ Service meow_compose          Built                                                                                                                                                0.8s
 ✔ Network meow_compose_default  Created                                                                                                                                              0.0s
 ✔ Container meow_sql            Started                                                                                                                                              0.2s
 ✔ Container meow_compose        Started
```
- curl sur la route `/users`
```
curl http://127.0.0.1:6942/users
[{"favorite_insult":"You are the human equivalent of Internet Explorer 6.","id":1,"name":"Lucas Dubois"},{"favorite_insult":"Your code looks like it was written by a pigeon.","id":2,"name":"Chloe Martin"},{"favorite_insult":"Your logic has more holes than a phishing email.","id":3,"name":"Leo Bernard"},{"favorite_insult":"You must be a deprecated function, because you have no support.","id":4,"name":"Manon Petit"},{"favorite_insult":"Your CSS is just a series of !important tags.","id":5,"name":"Hugo Durand"}]
```
- curl sur la route `/user/3`
```
curl http://127.0.0.1:6942/user/3
{"favorite_insult":"Your logic has more holes than a phishing email.","id":3,"name":"Leo Bernard"}
```
## Annexe

###### La commande `docker inspect 66fc6b8bd9cd` et son output

```
> docker inspect 66fc6b8bd9cd
[
    {
        "Id": "66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f",
        "Created": "2025-06-23T08:11:28.275360263Z",
        "Path": "python",
        "Args": [
            "app.py"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 34799,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2025-06-23T08:11:28.316022888Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:aa62b5955aa84ac21143ef9294108b06701d36d3e90ad49896e811066542a107",
        "ResolvConfPath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/hostname",
        "HostsPath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/hosts",
        "LogPath": "/var/lib/docker/containers/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f/66fc6b8bd9cd30fe42b8eb2b16c5f07745e18f273dba17ea7463de6f4c1de35f-json.log",
        "Name": "/modest_goodall",
        "RestartCount": 0,
        "Driver": "overlayfs",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "bridge",
            "PortBindings": {
                "8000/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "8000"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "ConsoleSize": [
                53,
                187
            ],
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "private",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": [],
            "BlkioDeviceWriteBps": [],
            "BlkioDeviceReadIOps": [],
            "BlkioDeviceWriteIOps": [],
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": null,
            "PidsLimit": null,
            "Ulimits": [],
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware",
                "/sys/devices/virtual/powercap"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": null,
            "Name": "overlayfs"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "66fc6b8bd9cd",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "8000/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "GPG_KEY=7169605F62C751356D054A26A821E680E5FA6305",
                "PYTHON_VERSION=3.13.5",
                "PYTHON_SHA256=93e583f243454e6e9e4588ca2c2662206ad961659863277afcdb96801647d640"
            ],
            "Cmd": [
                "python",
                "app.py"
            ],
            "Image": "it4lik/meow-api:arm",
            "Volumes": null,
            "WorkingDir": "/app",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "c18e29927a3d5777f8f2fa1428ffb5f34d863454ad5dfb501033cc6248cda3dd",
            "SandboxKey": "/var/run/docker/netns/c18e29927a3d",
            "Ports": {
                "8000/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "8000"
                    }
                ]
            },
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "6a14cee168a1a55fcf185f5bd2082b732bc305b04472ba822ce90cdc7d19d056",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null,
                    "NetworkID": "92028fc84abf3c36ec406a4b2bff55effbcefa85a627dfb2aba5e054b288f305",
                    "EndpointID": "6a14cee168a1a55fcf185f5bd2082b732bc305b04472ba822ce90cdc7d19d056",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "DNSNames": null
                }
            }
        }
    }
]
```