---
title:  "[GPU 클라우드 셋팅] Vast.ai 셋팅"
excerpt: "Vsat.ai를 이용하여 GPU 도커 컨테이너를 셋팅하는 방법을 설명합니다."
lang: ko
lang-ref: vastai-setup
permalink: /set_up/vastai-setup/
categories: 
  - set_up
tags:
  - GPU 서버
  - GPU 클라우드
  - GPU VM
  - GPU docker container
  - GPU 셋팅

toc_label: "목차"  # 목차 제목을 원하는 대로 설정
toc: true           # 목차 활성화
toc_sticky: true    # 스크롤 시 목차 고정

author: "limJhyeok"  # 포스트 작성자 이름
share: true        # 소셜 미디어 공유 버튼 활성화
comments: true     # 댓글 기능 활성화
related:
  - "[GPU 클라우드 셋팅] 사용 이유 및 사용방법(공통)"  # 관련 포스트 제목
  - "[GPU 클라우드 셋팅] Paperspace 셋팅"

date: 2024-11-10
last_modified_at: 2022-11-10
redirect_from: 
  - /set_up/gpu-cloud-setup/  # 이전 포스트에서 리디렉션
---

cf. 시간이 지나면서 Vast.ai의 UI가 바뀔 수 있기 때문에 아래 내용을 똑같이 따라하시기 힘드실 수 있습니다. 
다만 UI가 변해도 대략적인 흐름은 똑같을 것이므로 아래를 참고해서 GPU 도커 컨테이너를 쉽게 임대하실 수 있으실 거에요.


### 1. 회원가입 및 로그인

<img src="/images/assets/2024-11-10-17-09-46.png" width="100%" />

먼저 Vast.ai 홈페이지에 접속하면 위와 같은 메인 페이지가 보일 것입니다.

메인 페이지에서 오른쪽 상단에 Console 버튼을 클릭하시면 GPU를 임대할 수 있는 웹페이지로 이동하게 됩니다.

<img src="/images/assets/2024-11-10-17-13-15.png" width="100%" />

그러면 위의 그림과 같이 로그인(SIGN IN)을 할 수 있는 버튼이 오른쪽 상단에 존재하는데 먼저 로그인을 합니다.

<img src="/images/assets/2024-11-10-17-14-50.png" width="100%" />

로그인 및 회원가입을 할 수 있는 팝업창이 위와 같이 나타나게 되고 소셜로그인(Google, Github)을 지원하는 것을 확인할 수 있습니다.

저는 간단하게 소셜로그인으로 회원가입을 진행하도록 하겠습니다.

<img src="/images/assets/2024-11-10-17-21-48.png" width="100%" />

회원가입을 진행하게 되면 `SIGN IN` 버튼이 유저의 아이디 정보로 바뀌게 됩니다.

여기서 유저 아이디 정보 옆에 보시면 **Credit**이라는 문구가 보이는데 이 **Credit**이 GPU 서버를 임대할 수 있는 잔여 달러를 나타냅니다. 

그러면 이제 결제카드를 등록해서 **Credit**을 늘려 GPU를 임대해보도록 하겠습니다.

결제 카드 등록을 위해 왼쪽 사이드바에 보이는 BILLING 버튼을 클릭해주세요.

### 2. 결제 카드 등록

<img src="/images/assets/2024-11-10-17-26-16.png" width="100%" />

 BILLING 버튼을 누르면 위와 같은 화면이 나타날 것인데 여기서 `Payment Methods`의 **Add Card** 버튼을 클릭해주세요.

<div style="text-align : center;">
  <img src="/images/assets/2024-11-10-17-28-16.png" width="50%" height="30%"/>
</div>
그러면 위와 같이 개인정보와 카드의 정보를 등록할 수 있도록 페이지로 이동하게됩니다.

개인정보와 결제할 카드의 정보를 형식에 맞춰서 입력합니다.

<!-- TODO: 결제카드 등록 -->

<img src="/images/assets/2024-11-10-17-47-19.png" width="100%" />

결제카드를 등록한 후에 다시 BILLING 페이지로 돌아오면 `Payment Methods`에 카드가 등록이 된 것을 확인할 수 있습니다.

Vast.ai의 경우 미리 `Credit`을 카드를 통해 결제를 한 후 GPU 임대 시간에 따라 `Credit`을 차감하는 선결제 방식으로 이루어집니다.
    
Credit을 늘리기 위해 왼쪽에 **Add Credit** 버튼을 클릭해주세요.

<div style="text-align : center;">
  <img src="/images/assets/2024-11-10-17-50-26.png" width="75%" />
</div>

위 화면에서 얼마만큼의 금액(달러 기준)을 결제할 것인지, 그리고 결제 수단(e.g.,VISA)을 선택하신 후 **Add credit** 버튼을 클릭하신 후 결제를 진행하시면
선택하신 금액만큼 Credit이 충전될 것입니다.

### 3. GPU 인스턴스 설정 및 SSH key 등록

**3-1) SSH key 등록**

바로 GPU를 임대하기 전에 SSH key를 이용하여 안전하게 서버에 접근하기 위해 Vast.ai에 로컬 SSH Public key를 등록하도록 하겠습니다.

<img src="/images/assets/2024-11-10-17-38-55.png" width="100%" />

왼쪽 사이드바에서 **ACCOUNT** 버튼을 클릭하시면 위와 같은 화면이 나타납니다.

여기서 계정에 대한 작업들(비밀번호 초기화, 이메일 수정, SSH key 등록, 환경 변수 등록 등)을 할 수있습니다.

우선 저희는 SSH key를 등록하는 작업이 필요하기 때문에 오른쪽에 보이는 **ADD SSH KEY**를 클릭하도록 하겠습니다.

<img src="/images/assets/2024-11-10-17-39-40.png" width="100%" />

그러면 위와 같이 SSH key를 적을 수 있는 화면이 뜨게 됩니다.

- **SSH 키가 이미 있는 경우**: Public key를 복사하여 붙여넣어주세요.
- **SSH 키가 없는 경우**: 아래 SSH 키 생성 가이드에 따라 새로 생성한 후 Public key를 등록해주세요. 

**SSH 키 생성 가이드 (처음인 분들을 위한 간단한 설명)**

1. **터미널 또는 명령 프롬프트 열기**  
- **Linux/Mac**: 터미널(terminal)을 열어주세요.  
- **Windows**: git bash를 설치했다면 git bash를, 아니면 윈도우 터미널을 사용하세요.

2. **SSH 키 생성 명령어 실행**  
아래 명령어를 복사하여 터미널에 입력합니다.

    ```bash
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```

    **`-t rsa`**: RSA 알고리즘을 사용합니다.
    
    **`-b 4096`**: 4096비트 길이의 키를 생성합니다.
    
    **`-C`**: 키의 설명을 위해 이메일을 추가합니다.

3. **파일 위치 선택**  
키를 저장할 위치를 묻는 메시지가 나오면 기본 위치를 사용하려면 **Enter** 키를 누르세요.

4. **암호(passphrase) 설정**  
추가 보안을 위해 암호를 설정할 수 있습니다. 설정하지 않으려면 **Enter**를 누르면 됩니다.

5. **Public key 확인**  
모든 과정이 끝나면 아래 명령어로 생성된 Public key를 확인할 수 있습니다:

    ```bash
    cat ~/.ssh/id_rsa.pub
    ```

ref: [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)

이제 생성된 Public key를 복사하여 설정 화면에 붙여넣으시면 됩니다.

**3-2) GPU 인스턴스 설정**

<img src="/images/assets/2024-11-10-20-44-15.png" width="100%" />

GPU 서버를 임대하기 위해 왼쪽 사이드바에서 SEARCH 버튼을 누르면 화면과 같이 임대할 수 있는 GPU 리스트가 보입니다.

다만 이 상태에서 GPU 서버를 바로 임대하지는 못하고 어떤 도커 이미지를 통해서 컨테이너를 만들건지 정해야합니다.

초록색 박스 영역인 **EDIT IMAGE & CONFIG...**를 통해 원하는 도커 이미지와 셋팅을 Custom 할 수 있지만 먼저 왼쪽 사이드바에서 **TEMPLATES** 버튼을 클릭해 어떤 도커 이미지와 셋팅이 인기가 있는지 살펴보는 방향으로 설명을 드리겠습니다.

<img src="/images/assets/2024-11-10-20-46-11.png" width="100%" />

**TEMPLATES** 버튼을 클릭하면 위와 같은 화면이 보이는데, Vast.ai를 사용하는 유저들에게 추천하는 도커 이미지들이 보입니다.

이외에도 Recommended나 Popular와 같은 옵션을 선택해서 취향대로 고르시면 됩니다.

간단한 예시로 제일 처음에 보이는 PyTorch (cuDNN Runtime) Template의 **EDIT** 버튼을 클릭해서 설명을 계속 하겠습니다.

<img src="/images/assets/2024-11-10-20-49-33.png" width="100%" />

**EDIT** 버튼을 누르면 위와 같이 Template의 설정을 바꿀 수 있는 웹페이지로 전환됩니다.

**Docker Repository and Environment** 영역은 도커의 이미지와 관련한 부분입니다.

여기서 만약에 원하는 이미지 버전이 다르다면 버전을 다르게 적으실 수 있고 PyTorch 이미지가 아닌 Tensorflow 이미지를 원하신다면 Tensorflow 이미지에 맞는 도커 이미지 경로와 버전을 기입하시면 됩니다.

다음으로 **Docker Options** 은  `docker create/run`에 관련한 옵션으로 환경변수, port 등을 설정할 수 있습니다.

다음으로 **Launch Mode**의 경우 jupyter-python로 연결할 것인지 아니면 SSH를 통해 연결할 것인지 또는 Docker entrypoint로 실행할 것인지 선택하는 부분입니다.

저희는 SSH로 연결할 것이므로 `Run interactive shell server, SSH.`를 선택해줍니다.

**On-start Script**의 경우 컨테이너가 실행된 후 제일 먼저 어떤 script 명령어를 실행할 것인지에 대한 정의입니다.

현재 template에 작성된 명령어는 아래와 같습니다.

```bash
env >> /etc/environment
mkdir -p ${DATA_DIRECTORY:-/workspace/}
```
이에 대한 기능은

1. 현재 환경 변수 목록을 /etc/environment 파일에 추가

2. DATA_DIRECTORY 환경 변수가 설정되어 있는지 확인한 뒤, 해당 경로에 디렉토리를 생성합니다. 만약 DATA_DIRECTORY 변수가 설정되지 않았다면 기본 경로로 /workspace/ 디렉토리를 생성

입니다. 이외에 도커 레포지토리 인증, Template 이름 변경 등이 있는데 이부분에 대한 것은 기본 설정에 필요한 사항은 아니니 넘기도록 하겠습니다.

<img src="/images/assets/2024-11-10-21-01-39.png" width="100%" />

그 다음으로 제일 아래로 내리면 **Recommended Disk Space** 영역이 있습니다.

이는 Disk 사이즈를 정의하는 부분으로 데이터 크기와 딥러닝 모델 파일 크기 등을 고려해서 넉넉히 잡으시는게 좋습니다.

모든 설정을 마치셨다면 **SELECT AND SAVE** 버튼을 눌러줍니다.

<img src="/images/assets/2024-11-10-21-04-56.png" width="100%" />

그러면 다시 GPU 인스턴스를 선택하는 부분으로 리다이렉트 되는데, 이전과는 달리 **Instance Configuration**에 Template과 Image가 PyTorch로 변경된 것을 확인할 수 있습니다.

참고로, template을 수정하고 싶으시면 **EDIT IMAGE & CONFIG...** 버튼을 눌러서 다시 설정해주시면 되시고 disk 사이즈의 경우 **Disk Space To Allocate**를 통해 조절할 수 있습니다.

<img src="/images/assets/2024-11-10-21-09-33.png" width="100%" />

화면에 보이는 GPU 인스턴스에 대해 중요한 점만 설명드리겠습니다. Vast.ai 홈페이지에 접속해서 각 영역에 마우스를 갖다대면 대략적인 정보가 표시되니 직접 어떤 설정값들인지 확인하실 수 있습니다.

1X: GPU 1개라는 뜻입니다. (2X: 2개, 4X: 4개)

GTX 1070 TI: GPU 모델명

7.4 TFLOPS: Tera FLOPS로 GPU의 성능을 나타내는 지표

Max CUDA: 최대로 가능한 CUDA의 버전

8 GB: GPU RAM 크기

Quebec, CA: GPU 서버가 있는 위치(퀘백, 캐나다)

↑1685 Mbps: 인터넷 업로드 속도

↓1581 Mbps: 인터넷 다운로드 속도

$0.109/hr: 시간당 0.109 달러(credit) 차감

원하는 Template과 GPU 인스턴스를 구했으면 RENT 버튼을 클릭해서 GPU 컨테이너를 생성합니다. (약 30초 ~ 1분 가량 소모)

이후 왼쪽 탭의 INSTANCES를 통해 GPU 서버의 상태를 확인할 수 있습니다.

<img src="/images/assets/2024-11-10-21-22-04.png" width="100%" />
(이미지 출처: [Vast.ai Docs - instances](https://vast.ai/docs/console/instances))

**OPEN SSH interface** 버튼을 클릭하면 위 화면과 같이 SSH에 연결할 수 있게 정보가 뜰 것입니다.

여기서 Direct ssh connect의 경우 port는 42677 user는 root, IP 주소는 148.77.2.74인 것을 알 수 있습니다.

위 정보를 이용하여 VS Code에서 Vast.ai GPU 컨테이너를 연결하는 방법을 알려드리겠습니다.


- ref 
  1. [Vast.ai Docs - instances](https://vast.ai/docs/console/instances)
  2. [Vast.ai Docs - templates](https://vast.ai/docs/console/templates)
  
### 4. VS Code Remote 연결을 통한 원격 개발 환경 설정

VS Code에서 SSH 연결을 하려면 우선 [**Remote - SSH**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)  extension을 설치해야합니다. 

<img src="/images/assets/2024-11-06-17-39-41.png" width="100%" />

vscode를 열어 왼쪽의 Extension 메뉴를 열고 ssh를 검색한 후, 
Remote-SSH와 Remote-SSH:Editing Configuration Files를 찾아 설치해줍니다.

<img src="/images/assets/2024-11-06-17-57-49.png" width="100%" />

설치가 완료되면 ctrl + shift + p를 눌러 ssh를 검색해서 

Remote-SSH: Open SSH Configuration File을 누르고 

~/사용자/.ssh/config 파일을 열어줍니다. 

<img src="/images/assets/2024-11-10-21-26-58.png" width="100%" />

위와 같이 Host에 이름(e.g., vastai)을 적고 User에 root, HostName에 IP 주소인(148.77.2.74), Port에 42677을 적어줍니다.

<img src="/images/assets/2024-11-06-17-44-38.png" width="100%" />

파일을 닫고 다시 ctrl+shift+p를 눌러 ssh를 검색하고

Remote-SSH: Connect to Host를 들어갑니다. 

<img src="/images/assets/2024-11-10-21-27-18.png" width="100%" />

config 파일에서 입력한 서버 정보가 뜹니다. 

위 vastai를 클릭하면 SSH key 등록을 했으므로 따로 비밀번호를 입력하지 않고 서버에 연결할 수 있습니다.

<img src="/images/assets/2024-11-10-21-33-02.png" width="100%" />

연결이 되면 위와 같이 Welcome to your vast.ai container! ...와 같은 문구와 함께 root로 연결된 것을 알 수 있습니다.

### 5. GPU 상태 확인 (`nvidia-smi`)
    
<img src="/images/assets/2024-11-10-21-39-38.png" width="100%" />

shell에 `nvidia-smi` 명령어를 통해 올바르게 GPU가 셋팅이 되었는지 확인합니다.

만약 도커 이미지를 NVIDIA 드라이버가 설치되지 않은 이미지로 컨테이너를 구축하셨으면 위 명령어가 동작하지 않을 수 있습니다.
    
### 6. **GPU 서버 종료 및 삭제**
    
GPU 서버를 다 사용하신 후에는 서버를 종료(stop)하거나 삭제(destroy)해야 비용이 절감됩니다.

서버 종료(stop)의 경우 disk 비용만 내므로 비용절감이 되고

삭제(destroy)의 경우 GPU 서버의 모든 컴퓨팅 자원을 반납하는 것이므로 더이상 비용이 발생하지 않게됩니다.

다만 삭제(destroy)의 경우 컨테이너 내에 있는 데이터나 환경설정을 복구할 수 없으므로 신중히 하셔야합니다.

<img src="/images/assets/2024-11-10-21-36-23.png" width="100%" />
(이미지 출처: [Vast.ai Docs - instances](https://vast.ai/docs/console/instances))

서버 종료(stop)의 경우 보라색으로 표시된 검은색 네모 표시를 클릭하면 됩니다.

서버 삭제(destroy)의 경우 빨간색으로 표시된 휴지통 표시를 클릭하면 됩니다.

<img src="/images/assets/2024-11-10-21-37-21.png" width="100%" />
(이미지 출처: [Vast.ai Docs - instances](https://vast.ai/docs/console/instances))

종료된 서버를 다시 활성화 시키고 싶으시면 빨간색으로 표시된 재생 표시를 클릭하면 됩니다.

