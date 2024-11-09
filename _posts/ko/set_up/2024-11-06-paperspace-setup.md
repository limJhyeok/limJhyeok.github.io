---
title:  "[GPU 클라우드 셋팅] Paperspace 셋팅"
excerpt: "Paperspace를 이용하여 GPU 가상머신(VM)을 셋팅하는 방법을 설명합니다."
lang: ko
lang-ref: paperspace-setup
permalink: /set_up/paperspace-setup/
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
image: "/assets/images/paperspace-setup.jpg"  # 포스트 대표 이미지 경로
share: true        # 소셜 미디어 공유 버튼 활성화
comments: true     # 댓글 기능 활성화
related:
  - "[GPU 클라우드 셋팅] 사용 이유 및 사용방법(공통)"  # 관련 포스트 제목
  
date: 2024-11-06
last_modified_at: 2022-11-09
redirect_from: 
  - /set_up/gpu-cloud-setup/  # 이전 포스트에서 리디렉션
---

cf. 시간이 지나면서 Paperspace의 UI가 바뀔 수 있기 때문에 아래 내용을 똑같이 따라하시기 힘드실 수 있습니다. 
다만 UI가 변해도 대략적인 흐름은 똑같을 것이므로 아래를 참고해서 GPU 가상머신(VM)을 쉽게 임대하실 수 있으실 거에요.

### 1. 회원가입 및 로그인
    
소셜로그인(Google, github 등)을 통해 회원가입을 진행하면 
1. 스마트폰 인증 
2. 이름 인증 
3. product 선택(`gradient` 또는 `CORE`) 
4. 간단한 설문(직업 등)
의 과정을 거치게 됩니다.

product의 경우 `gradient` 또는 `CORE`가 존재하는데, 

`gradient`는 머신러닝 및 딥러닝 모델의 개발, 훈련, 배포를 간소화하는 플랫폼입니다.

`CORE`의 경우 Paperspace의 가상 머신(VM)으로 GPU, CPU, 스토리지, 네트워킹 등 클라우드 컴퓨팅 자원을 제공합니다.

이번 글에서 살펴볼 것은 VM인 Paperspace의 `CORE`이므로 `CORE`를 선택해줍니다.

cf. `gradient`와 `CORE`는 추후에도 어떤 서버를 임대할 것인지 선택할 때 계속 바꿀 수 있으므로 부담가시지 않으셔도 됩니다.

### 2. 결제 카드 등록

<img src="/images/assets/2024-11-06-17-53-41.png" width="100%"/>

회원가입을 하시면 위와 비슷한 화면이 나타날 것입니다.

왼쪽 상단에 `CORE` 서비스를 뜻하는 로고가 있고 화면 중앙 왼쪽에 `CREATE A MACHINE` 버튼이 있습니다.

(만약, 위와 같은 화면이 아닐경우 왼쪽 상단에 `gradient` 서비스 로고로 되어있을 것이고 토글을 통해 `CORE`로 바꾸실 수 있습니다.)

GPU를 임대하기 위해 `CREATE A MACHINE` 버튼을 클릭하겠습니다.
    
<img src="/images/assets/2024-11-06-17-54-07.png" width="100%" />

`CREATE A MACHINE` 을 클릭하면 위와 같이 새로운 Machine을 선택하기 위한 창이 나타납니다.

저희는 아직 결제 카드 등록을 안했기 때문에 위의 노란색 박스로 결제 수단이 필요하다는 문구가 보입니다.
`ADD A CREDIT CARD` 버튼을 클릭해서 결제 카드를 등록하도록 하겠습니다.

<img src="/images/assets/2024-11-06-17-54-17.png" width="100%" />

결제 카드 등록버튼을 누르면 위와 같이 개인정보와 카드의 정보를 등록할 수 있도록 팝업창이 표출됩니다.

개인정보와 결제할 카드의 정보를 형식에 맞춰서 입력합니다.

<img src="/images/assets/2024-11-06-17-54-27.png" width="100%" />
    
카드를 등록하면 위에 있던 결제 수단 등록을 요청하는 노란색 박스가 없어졌을 것입니다.
    
### 3. GPU 인스턴스 설정 및 SSH key 등록
**3-1) GPU, OS, Disk 설정**
    
Select a machine 토글을 눌러서 원하는 Machine을 아래에서 선택을 합니다.

<img src="/images/assets/2024-11-06-17-54-40.png" width="100%" />

위의 GPU, Multi-GPU, CPU, All 의 선택지가 존재합니다.

GPU: 한 대의 GPU를 임대하는 방식 

Multi-GPU: 여러 대의 GPU를 동시에 묶어서 임대하는 방식

CPU: GPU 없이 CPU만 존재하는 서버를 임대하는 방식

All: 위의 세가지를 모두 묶은 선택지

가장 기본이 되는 GPU 옵션을 살펴보면 모델명과 한 시간에 얼마의 가격(달러 기준)인지, CPU의 스펙은 어떻게 되는지가 간단히 적혀있습니다.

이 중에서 원하는 GPU 스펙을 선택하고 다음으로 넘어가겠습니다.
    
<img src="/images/assets/2024-11-06-17-55-15.png" width="100%" />

아차! 다음으로 넘어가려고 했는데 V100 GPU 서버를 임대하기 위해서는 Paperspace측의 승인이 필요하다고 합니다.
참고로 이는 V100뿐만 아니라 다른 GPU(Multi-GPU 포함)도 마찬가지입니다.
    
(참고로 한 번 승인을 받았다고 해서 모든 GPU를 사용할 수 있는게 아닙니다. 특정 그룹별로 승인 요청이 다르기 때문에 모두 이용하려면 각 그룹별로 승인 요청을 드려야합니다.)
    
**How do you Intend to use this machine?** 텍스트 박스를 선택해서 GPU 서버 사용 목적을 입력하고 REQUEST MACHINE TYPE 버튼을 클릭하겠습니다.

(사용 목적을 자세히 적지 않을 시 반려당하거나 추가 정보를 요청할 수 있으니 자세히 적어주세요.)
    
<img src="/images/assets/2024-11-06-17-55-27.png" width="100%" />     

위의 승인을 받기 위해서는 Business day로 하루에서 이틀정도 걸린다고 적혀있습니다.

승인 결과는 메일로 오며 실제로 저는 승인을 받기 위해 하루정도 걸렸습니다.

<img src="/images/assets/2024-11-06-17-55-34.png" width="100%" />

승인을 받은 후에는 이제 GPU Machine을 선택할 수 있습니다.

먼저 모델은 아까와 같이 GPU 스펙과 가격을 고려해서 정하시면 됩니다. 

**OS Template**

다음으로 OS Template을 정해야 합니다. OS는 현재 크게 Ubuntu, Window, CentOS가 존재합니다.
    
**Disk size**

이후로 Disk size를 정해야하는데 학습하고자 하는 데이터 크기와 딥러닝 모델 파일 크기를 고려해서 용량을 넉넉히 잡으시는게 좋습니다.

또한 Disk도 가격에 포함이 되는 것을 인지하시고 골라주세요.

**Machine name**    

다음으로 Machine name을 정해야 하는데 각자의 취향대로 적어주시거나 프로젝트 이름을 적어주시면 됩니다. 
            
**3-2) Network 설정**

<img src="/images/assets/2024-11-06-17-55-42.png" width="100%" />


먼저 **Region**은 어느 지역에 있는 서버를 임대할 것인가 입니다. 일반적으로 사용자의 지역과 가까운 지역일수록 Network 연결이 보다 잘되겠죠? 이를 고려해서 선택하시면 됩니다.

**Public IP** 설정은 인터넷을 사용할 것인가인데 인터넷 환경이 필요없는 개발환경이면 None을 선택하셔도 됩니다. 하지만 github 연결 또는 인터넷을 통한 데이터 다운로드/업로드 등에 어려움이 있다는 점을 고려해주세요.

Dynamic과 Static의 차이는 Public IP를 고정할것이냐 말것이냐인데 IP를 고정할 필요가 없으시면 Dynamic으로 설정하시면 됩니다.

**Private network** 설정도 지원하는데 저는 패스하도록 하겠습니다. 

**3-3) Authentication and Access 설정**

이제 `Authentication and Access` 설정에서 로컬 컴퓨터의 SSH 키를 GPU 서버에 등록하게 됩니다.

<img src="/images/assets/2024-11-06-17-55-53.png" width="100%" />

(참고 문서: [Paperspace > Accounts & Teams > Add SSH Keys](https://docs.digitalocean.com/products/paperspace/accounts-and-teams/add-ssh-keys/))

- **SSH 키가 이미 있는 경우**: Public key를 복사하여 붙여넣고 이름을 지정해주세요.
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

이제 생성된 Public key를 복사하여 설정 화면에 붙여넣으시면 됩니다.

**3-4) Snapshots 설정(참고: [Paperspace snapshot](https://docs.digitalocean.com/products/paperspace/machines/how-to/manage-snapshots/))**

<img src="/images/assets/2024-11-06-17-56-05.png" width="100%" />

다음으로 `Snapshots` 설정인데 `Snapshots`은 현재 서버의 상태(환경, 데이터 등)를 백업하는 기능입니다. 서버가 예상치 못하게 내려가는 것과 같은 만일의 사태를 대비하기 위한 용도로 주요 사용합니다.

설정을 통해 `Snapshot` 주기를 설정할 수 있고 얼마만큼의 `Snapshot`을 저장할 것인지 설정할 수 있습니다.
        
**3-5) Starting State**

<img src="/images/assets/2024-11-06-17-56-12.png" width="100%" />
    
다음으로 `Starting State` 설정을 통해 Machine을 생성과 동시에 바로 가동시킬 것인지 아니면 나중에 직접 가동시킬 것인지 선택할 수 있습니다.

`Starting State` 아래에는 시간당 가격(Price summary)이 적혀있고 `CREATE MACHINE` 버튼을 통해 설정한대로 Machine이 만들어지게 됩니다.

<img src="/images/assets/2024-11-06-17-56-21.png" width="100%" />
        
**3-6) GPU 인스턴스 SSH 정보 확인**
    
<img src="/images/assets/2024-11-06-17-57-03.png" width="100%" />

Connect 버튼을 누르면 위와 같이 ssh에 연결할 수 있도록 host name(여기서는 paperspace)과 IP(@ 뒤의 숫자)가 주어집니다.

이를 통해 터미널 또는 IDE에서 ssh 연결을 할 수 있습니다.
    
### 4. VS Code Remote 연결을 통한 원격 개발 환경 설정

VS Code에서 SSH 연결을 하려면 우선 [**Remote - SSH**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)  extension을 설치해야합니다. 

<img src="/images/assets/2024-11-06-17-39-41.png" width="100%" />

vscode를 열어 왼쪽의 Extension 메뉴를 열고 ssh를 검색한 후, 
Remote-SSH와 Remote-SSH:Editing Configuration Files를 찾아 설치해줍니다.

<img src="/images/assets/2024-11-06-17-57-49.png" width="100%" />

설치가 완료되면 ctrl + shift + p를 눌러 ssh를 검색해서 

Remote-SSH: Open SSH Configuration File을 누르고 

~/사용자/.ssh/config 파일을 열어줍니다. 

<img src="/images/assets/2024-11-06-17-58-16.png" width="100%" />

위와 같이 Host에 host name인 paperspace를 적고 HostName에 IP 주소를 적습니다.

<img src="/images/assets/2024-11-06-17-44-38.png" width="100%" />

파일을 닫고 다시 ctrl+shift+p를 눌러 ssh를 검색하고

Remote-SSH: Connect to Host를 들어갑니다. 

<img src="/images/assets/2024-11-06-17-58-34.png" width="100%" />

config 파일에서 입력한 서버 정보가 뜹니다. 

위 paperspace를 클릭하면 SSH key 등록을 했으므로 따로 비밀번호를 입력하지 않고 서버에 연결할 수 있습니다.

<img src="/images/assets/2024-11-06-17-45-17.png" width="100%" />

서버에 연결이 되면 Shell의 host가 paperspace인 것을 확인할 수 있습니다.

### 5. GPU 상태 확인 (`nvidia-smi`)
    
<img src="/images/assets/2024-11-06-17-58-45.png" width="100%" />

shell에 `nvidia-smi` 명령어를 통해 올바르게 GPU가 셋팅이 되었는지 확인합니다. 참고로 저는 RTX 4000을 빌렸기 때문에 RTX 4000이 배정된 것도 확인할 수 있네요.

이후에는 각자 실험/개발 환경에 필요한 셋팅을 해야하는데 docker image로 구축한 것이 아닌 VM으로 OS만 셋팅했기 때문에 실험이나 개발을 진행하기 위해서는 사용자가 직접 환경 구축을 해야하는 점이 단점입니다.

대신 컨테이너 기반 클라우드 서비스보다 자유도가 더 높다는 점이 장점입니다.
    
### 6. **GPU 서버 종료 및 삭제**
    
GPU 서버를 다 사용하신 후에는 서버를 종료(`shutdown`)하거나 삭제(`deactivate`)해야 비용이 절감됩니다.

서버 종료(`shutdown`)의 경우 GPU를 사용하지 않게 되므로 비용절감이 되고

삭제(`deactivate`)의 경우 GPU 서버의 모든 컴퓨팅 자원을 반납하는 것이므로 더이상 비용이 발생하지 않게됩니다.

다만 삭제(`deactivate`)의 경우 따로 `template`을 만들지 않는이상 작업했던 내용을 복구할 수 없으므로 신중하게 선택하셔야 합니다. 

- **서버 종료(shutdown)**
    
**방법 1: Paperspace UI를 활용한 종료**

<img src="/images/assets/2024-11-06-18-00-59.png" width="75%" height="65%" />

Machine의 오른쪽 위에 있는 … 버튼을 눌러서 `Shutdown` 버튼을 클릭합니다.

**방법 2: shell을 활용한 종료**

paperspace shell에서

```bash
sudo shutdown now
```

를 통해 서버를 종료합니다. (local 컴퓨터 shell에서 위의 명령어를 치지 않도록 조심하세요.)

서버가 종료된 후에는 아래와 같이 서버의 상태가 off 로 바뀌게 됩니다.

<img src="/images/assets/2024-11-06-18-01-07.png" width="65%" height="50%" />
    
- **서버 삭제(deactivate)**
    
<img src="/images/assets/2024-11-06-18-01-17.png" width="65%" height="50%" />

`Deactivate` 버튼을 클릭해서 서버를 삭제합니다

### 7. **Template 생성 및 활용**

**7-1) Template이 필요한 이유**

Machine 생성 후 로컬 SSH key 변경이나 Disk 용량 변경이 필요할 경우 Machine을 다시 생성해야 합니다. 이때 개발 환경 설정을 처음부터 반복해야 하는 불편함이 있습니다. Paperspace CORE는 이런 문제를 해결하기 위해 Template 기능(스냅샷)을 제공합니다. Template을 사용하면 개발 환경 설정 없이 서버를 즉시 이관할 수 있습니다.

<img src="/images/assets/2024-11-06-17-59-12.png" width="65%" height="50%" />

**7-2) Template 생성 방법**

먼저 **Template**을 만들기 위해 서버를 종료(`SHUTDOWN`) 해주세요.

그리고 Template을 만들기 위해서 위의 Machine에서 CONNECT 버튼과 ... 버튼을 제외한 박스영역을 선택해 주세요. 그러면 Machine의 상세 내용을 보여주는 웹페이지로 이동하게 됩니다.

<img src="/images/assets/2024-11-06-19-57-32.png" width="65%" />

상세내용 화면에서 오른쪽에 보시면 **Detail**, **Snapshots**, **Templates**, **Logs**, **Setting** 버튼들이 보이실 것입니다.

<img src="/images/assets/2024-11-06-17-59-24.png" width="100%" />

오른쪽에 **Templates** 버튼을 클릭해줍니다.

그러면 왼쪽에 `CREATE TEMPLATE` 버튼이 보이는데 이를 클릭해줍니다. 

<img src="/images/assets/2024-11-06-17-59-32.png" width="80%" />

Template 이름을 지어주고 `CREATE TEMPLATE` 버튼을 클릭해서 현재 VM의 상태를 저장합니다.

<img src="/images/assets/2024-11-06-18-00-33.png" width="100%" />

**Template**을 이용해서 다시 Machine을 만들고 싶으시면 **Templates** 탭으로 이동한 후에 원하는 Template의 … 버튼을 클릭해서 `Create machine from template`을 클릭합니다.

<img src="/images/assets/2024-11-06-18-00-41.png" width="100%" />

`OS Template`에서 **내가 선택한 Template**인지 확인하고 다시 Machine 설정을 선택한 후에 `CREATE MACHINE`을 클릭하면 이전과 동일한 셋팅의 Machine을 얻을 수 있습니다.

**7-3) TIP: Template을 통한 비용 절감**

Template의 경우 Template 용량에 해당하는 Disk 비용만 청구되기 때문에 프로젝트를 오래 멈춰야 하는 상황이 생길 경우 이를 Template으로 만들어서 보관하면 비용을 아끼면서 환경구축을 다시 해야하는 시간도 단축할 수 있습니다.
