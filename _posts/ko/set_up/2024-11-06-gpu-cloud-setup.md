---
title:  "[GPU 클라우드 셋팅] 사용 이유 및 사용방법(공통)"
excerpt: "GPU 클라우드 서버를 사용하는 이유와 공통적으로 어떻게 셋팅하는지 설명합니다."
lang: ko
lang-ref: gpu-cloud-setup
permalink: /set_up/gpu-cloud-setup/
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
image: "/assets/images/gpu-cloud-setup.jpg"  # 포스트 대표 이미지 경로
share: true        # 소셜 미디어 공유 버튼 활성화
comments: true     # 댓글 기능 활성화
related:
  - "기타 GPU 클라우드 관련 포스트"  # 관련 포스트 제목
  - "GPU 서버 최적화 방법"
  
date: 2024-11-06
last_modified_at: 2022-11-06
redirect_from: 
  - /old-gpu-cloud-post  # 이전 포스트에서 리디렉션
---

## 목차

1. **GPU 클라우드 서버란?**
2. **Paperspace와 Vast.ai 개요 및 특징**
3. **Paperspace 및 Vast.ai 공통 설정 단계**
    - 회원가입 및 로그인 (Google 소셜 로그인 사용)
    - 결제 카드 등록 및 SSH 키 설정
    - GPU 인스턴스 생성
        - 이미지 및 초기 설정 선택
        - RAM, CPU, GPU, 드라이브 등 컴퓨터 리소스 설정
    - GPU 인스턴스 구매 및 SSH 정보 확인
    - VS Code Remote 연결을 통한 원격 개발 환경 설정
    - GPU 상태 확인 (`nvidia-smi` 등)
---

## **GPU 클라우드 서버란?**

GPU 클라우드 서버는 물리적인 GPU를 클라우드 환경에서 원격으로 사용할 수 있는 서비스입니다. 이를 통해 사용자는 고성능의 GPU 서버에 접근해 딥러닝 모델 학습이나 고도의 연산 작업을 효율적으로 수행할 수 있습니다.

### 장점

1. **유연성**
    - 다양한 스펙의 GPU를 필요할 때마다 선택하여 사용 가능하며, 하드웨어를 직접 구매 또는 셋팅할 필요가 없습니다.
    - 프로젝트에 맞춰 GPU 리소스를 확장하거나 축소할 수 있어 사용이 편리합니다.
2. **비용**
    - GPU 연산이 필요한 순간에만 서버를 임대해 사용할 수 있어 초기 투자와 유지 비용이 절감됩니다.
    - 고가의 장비를 매번 구입하지 않고, 최신 GPU를 임대해서 작업할 수 있어 장기적으로 비용 효율적입니다.
3. **시간 제약 X**
    - 클라우드 서버는 시간 제한이 없으므로, Google Colab에서 불편했던 장기 작업을 안정적으로 수행할 수 있습니다.
4. **프로젝트 설정이 용이함**
    - Google Colab은 GitHub와의 연동이 번거롭고, Jupyter Notebook 기반이라 모듈 단위로 프로젝트를 관리하는 데 한계가 있는 반면 클라우드 서버를 임대할 경우 가상의 컴퓨터를 임대하는 형식이므로 프로젝트 설정이 용이합니다.

### 단점

1. **장기 사용 시 비용**
    - 짧은 기간 사용에는 효율적이지만, 장기적으로 사용 시 비용이 누적될 수 있습니다.
2. **네트워크 의존성**
    - 클라우드 서버에 접근하려면 안정적인 네트워크 연결이 필요하며, 데이터 전송 시 대역폭 제약이 있을 수 있습니다.
3. **번거로움**
    - GPU 클라우드 서버를 새로 임대할 때마다 서버 스펙을 새로 정하고 매번 ssh key를 다시 설정해야하는 등의 번거로움이 있습니다.

## **Paperspace와 Vast.ai 개요 및 특징**

GPU 클라우드 서비스를 제공하는 업체는 여러군데가 있지만 이 중에서 이번 포스팅 시리즈에서는 Paperspace와 Vast.ai에 대해 다루겠습니다.

이에 대한 이유로는 Paperspace(CORE)는 Virtual Machine(VM) 기반이고 Vast.ai는 Container(e. g., docker) 기반으로 서로 다른 특징이 있기 때문에 이 두 업체를 다룰 예정입니다.

- **Paperspace(CORE)**:
    - GPU 기반 고성능 인스턴스를 가상 머신(VM) 형태로 제공하는 클라우드 서비스입니다.
    - 컨테이너가 아닌 VM 형태이므로 쉽게 컨테이너를 생성할 수 있습니다
- **Vast.ai**
    - 마켓플레이스 방식으로 GPU 서버를 임대할 수 있는 서비스입니다. Docker 컨테이너로 구동되어 가볍고 빠릅니다.
    - 컨테이너이기 때문에 또다른 컨테이너를 띄우려면 도커 인 도커(Docker in Docker)와 같은 기술을 사용해야할 것으로 보입니다.
        
        cf) 작성자도 해본적은 없습니다. 권한 때문에 막힐 수도 있습니다.
        

## **Paperspace 및 Vast.ai 공통 설정 단계**

### 1. 회원가입 및 로그인

- 두 서비스 모두 소셜 로그인(e. g., Google)으로 빠르게 가입하고 로그인할 수 있습니다

### 2. 결제 카드 등록 및 SSH 키 설정

- **결제 카드 등록**
- **SSH 키 설정**
    - 원격 서버에 안전하게 접근하기 위해 SSH 키를 설정합니다.

### 3. GPU 인스턴스 생성

- **이미지 및 초기 설정 선택**
    - 인스턴스 생성 시 기본 운영체제(window, ubuntu 등) 또는 딥러닝 프레임워크(pytorch, tensorflow 등)가 사전 설치된 이미지를 선택할 수 있습니다
- **컴퓨터 리소스 설정 (RAM, CPU, GPU, 드라이브, 네트워크 등)**
    - **GPU**
        - 모델(e. g., A100, RTX-3090 등)
        - RAM(32GB, 64GB 등)
    - **RAM/CPU**
        - 용량
        - 속도
    - **드라이브**
        - 딥러닝 학습의 경우 데이터 양과 모델 크기 또한 무시할 수 없기 때문에 드라이브 용량도 주의깊게 보신 후 선택하셔야 합니다.
    - **네트워크**
        - 잦은 네트워크 작업(e. g., 파일 업로드 및 파일 다운 등)이 빈번할 경우 네트워크 속도가 높은 인스턴스를 고르셔야 합니다.

### 4. GPU 인스턴스 구매 및 SSH 정보 확인

- **GPU 인스턴스 구매**
- **SSH 접속 정보 확인**
    - 계정이름(e. g., root)
    - IP(e. g., 123.45.67.890)
    - Port(e. g., 12345)
    
    ```bash
    ssh root@123.45.67.890:12345
    ```
    

### 5. VS Code Remote 연결을 통한 원격 개발 환경 설정

- VS Code [**Remote - SSH**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) extension 설치
- SSH 설정
    - 구매한 인스턴스의 HostName, Port, User, Host 설정 기입
- SSH를 통해 VM 또는 컨테이너 진입

### 6. GPU 상태 확인 (`nvidia-smi` 등)

- **GPU 상태 확인**
    - 인스턴스가 정상적으로 구동되었는지 확인하기 위해 터미널에서 `nvidia-smi` 명령어를 실행합니다.
        
        cf. nvidia 드라이버가 설치되어있지 않다면 GPU가 존재해도 (일반적으로) 이를 딥러닝 학습에 활용할 수 없습니다.
