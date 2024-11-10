---
title:  "[GPU Cloud Setting] (General) Why we use and How to setting"
excerpt: "Why we use GPU cloud service and how to setting it generally"
lang: en
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
  - "[GPU Cloud Setting] Paperspace setting"  # 관련 포스트 제목
  - "[GPU Cloud Setting] Vast.ai setting"
    
date: 2024-11-06
last_modified_at: 2022-11-09
redirect_from: 

---

## **GPU Cloud Server?**

A GPU cloud server is a service that allows users to access physical GPUs remotely in a cloud environment. This enables users to efficiently train deep learning models or perform high-performance computations by accessing powerful GPU servers.

### Advantages

1. **Flexibility**
    - You can select from various GPU specifications as needed, without the need to purchase or set up hardware yourself.
    - GPU resources can be scaled up or down according to project requirements, making it convenient to use.
2. **Cost**
    - You can reduce initial investment and maintenance costs by renting the server only when GPU computation is required.
    - It is cost-effective in the long term because you can rent the latest GPUs instead of purchasing expensive hardware every time you need it.
3. **No Time Constraints**
    - Cloud services do not have time limits, allowing you to perform long-running tasks that would be difficult in Google Colab.
4. **Easy Project Set Up**
    - Google Colab can be cumbersome when connecting to GitHub, and managing projects as modules is limited due to its Jupyter Notebook-based environment. However, renting a cloud server allows for easier project set up, as it provides access to a virtual machine

### Disadvantages
1. **Long-Term Costs**
    - While it is cost-effective for short-term use, costs can accumulate over time when using the server for extended periods.
2. **Network Dependency**
    - A stable network connection is required to access the cloud server, and bandwidth limitations may occur during data transfer.
3. **Cumbersome**
    - It can be cumbersome to set up the server specifications and SSH keys each time you rent a new GPU cloud server.

## **Overview of Paperspace and Vast.ai and Their Features**

There are several companies that offer GPU cloud services. but in this post series, I will focus on Paperspace and Vast.ai. (If you're looking for more GPU cloud service providers, you can search for them.)

The reason for this is that Paperspace(CORE) is based on Virtual Machines (VMs), while Vast.ai is based on Containers(e. g., Docker), resulting in different features for each company. For this reason, I will focus on these two companies

ref: [Containers versus virtual machines (VMs)](https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-a-container/#containers-versus-virtual-machines-vms)

- **Paperspace(CORE)**

A cloud service that offers high-performance GPU-based instances in the form of virtual machines (VMs).

Since it’s VM-based rather than container-based, it’s easy to create containers on this platform. (e.g., docker-compose)


- **Vast.ai**

A marketplace-style service where you can rent GPU servers. It operates in a lightweight, fast container-based environment.

Since it's container-based, you may need to use a technique like "Docker in Docker" if you want to run additional containers within Vast.ai

*Note: I haven't personally tried this, and it might be restriced due to permission limitations.*

## **Common Set Up Steps for Paperspace and Vast.ai**

### 1. Sign Up and Log In

- Both services offer social login options (e.g., Google), allowing you to sign up and log in quickly.

### 2. Credit Card Registration and SSH Key Set Up

- **Credit Card Registration**
- **SSH Key Set Up**

Set up an SSH key to securely access the remote server.

### 3. GPU Instance Set Up

**3-1) Select Image and Initial Configuration**

When creating an instance, you can choose a base operating system (Windows, Ubuntu, etc.) or an image with pre-installed deep learning frameworks (e.g., PyTorch, TensorFlow).

**3-2) Computer Resource Set Up (GPU, RAM, CPU, Drive, Network, etc.)**
  - **GPU**

Select model(e.g., A100, RTX-3090, etc.)

Select GPU memory(32GB, 64GB, etc.)

  - **RAM/CPU**

Select capacity

Select speed


  - **Drive**

Carefully select the drive capacity, as data and model sizes can be substantial in deep learning training.

  - **Network**

Choose an instance with high network speed if network tasks (e.g., file uploads and downloads) are frequent.

### 4. Purchase GPU Instance And Verify SSH Information

4-1) **Purchase GPU instance**

4-2) **Verify SSH Information**

  - Username(e.g., root)

  - IP Address(e.g., 123.45.67.890)

  - Port(e.g., 12345)

  ```bash
  ssh root@123.45.67.890:12345
  ```

### 5. Setting Up Remote Development Environment via VS Code Remote SSH Extension

**5-1) Install VS Code [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)**

**5-2) Configure SSH**

**5-3) Access VM or Container via SSH**

### 6. Verify GPU Status (`nvidia-smi` 등)

To verify if the instance is running correctly, execute the `nvidia-smi` command in the terminal.

**cf.** If the NVIDIA driver is not installed, the GPU cannot be used for deep learning training, even if it exists.