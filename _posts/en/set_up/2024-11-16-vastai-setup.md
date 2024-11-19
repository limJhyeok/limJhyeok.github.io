---
title:  "[GPU Cloud Setting] Vast.ai setting"
excerpt: "How to setting GPU Docker Container using Vast.ai"
lang: en
lang-ref: vastai-setup
permalink: /set_up/vastai-setup/
categories: 
  - set_up
tags:
  - GPU server
  - GPU cloud
  - GPU VM
  - GPU docker container
  - GPU setup

toc_label: "table of contents"  # 목차 제목을 원하는 대로 설정
toc: true           # 목차 활성화
toc_sticky: true    # 스크롤 시 목차 고정

author: "limJhyeok"  # 포스트 작성자 이름
share: true        # 소셜 미디어 공유 버튼 활성화
comments: true     # 댓글 기능 활성화
related:
  - "[GPU Cloud Setting] (General) Why we use and How to setting"  # 관련 포스트 제목
  - "[GPU Cloud Setting] Paperspace setting"

date: 2024-11-16
last_modified_at: 2022-11-16
redirect_from: 
  - /set_up/gpu-cloud-setup/  # 이전 포스트에서 리디렉션
---

cf. It may be difficult to follow the exact steps below, as the Vast.ai UI might change over time. However, the overall process of renting a GPU Docker Container will remain similar, so you can still easily rent one by referring to the steps below.

### 1. Sign Up and Log In

<img src="/images/assets/2024-11-10-17-09-46.png" width="100%" />

First, when you visit the Vast.ai homepage, you will see a main page like the one show above. By clicking the “Console” button in the top-right corner of the main page, you will be redirected to a webpage where you can rent GPUs.

<img src="/images/assets/2024-11-10-17-13-15.png" width="100%" />

In the top-right corner, as shown above, there is a “SIGN IN” button. First, sign in.

<img src="/images/assets/2024-11-10-17-14-50.png" width="100%" />

A pop-up window for signing in or signing up will appear as shown above, and you can see that social login(Google, Github) is supported.

I will proceed with signing up easily using social login.

<img src="/images/assets/2024-11-10-17-21-48.png" width="100%" />

After signing up, the SIGN IN button will change to display the user’s account information.

Next to the account information, you’ll see the **Credit** label, which shows the remaining balance(in dollars) available for renting a GPU server.

Now, let’s increase the **Credit** by adding a payment card to rent a GPU server.

Please click the **BILLING** button on the left sidebar to register your payment card.

### 2. Enroll The Credit Card

<img src="/images/assets/2024-11-10-17-26-16.png" width="100%" />

When you click the **BILLING** button, a screen like the one shown above will appear. Click the **Add Card** button under **Payment Methods**.

<div style="text-align : center;">
  <img src="/images/assets/2024-11-10-17-28-16.png" width="50%" height="30%"/>
</div>
You will then be redirected to a page where you can enter your personal and credit card information, as shown above.

Fill out your personal and card details in the provided form

<img src="/images/assets/2024-11-10-17-47-19.png" width="100%" />

After adding your card, you can confirm that it has been added to **Payment Methods** when you return to the **BILLING** page.

In Vast.ai, you need to prepay for Credit using your card. The service deducts Credit based on GPU rental hours.

To add more Credit, please click the **Add Credit** button on the left

<div style="text-align : center;">
  <img src="/images/assets/2024-11-10-17-50-26.png" width="75%" />
</div>

Credit will be added based on the amount you select and the payment method you choose (e. g., VISA) after clicking the **Add Credit** button to proceed with the payment.

### 3. GPU Instance Setup and SSH Key Registration

**3-1) SSH key Registration**

Before renting a GPU, we will register the local SSH Public key on Vast.ai to securely access the server using SSH.

<img src="/images/assets/2024-11-10-17-38-55.png" width="100%" />

When you click the **ACCOUNT** button on the left sidebar, a screen like the one shown above will appear.

Here, you can perform various account-related tasks, such as resetting your password, modifying your email, registering an SSH key, or setting environment variables.

First, we need to register an SSH key, so click the **ADD SSH KEY** button on the right.

<img src="/images/assets/2024-11-10-17-39-40.png" width="100%" />

Then, the screen where you can enter your local SSH key, as shown above, will appear.

- **If you already have an SSH key:**: Copy the public key, paste it.

- **If you don’t have an SSH key**: Follow the SSH key generation guide below to create a new SSH key and register the public key.

**SSH Key Generation Guide (simple explaination for beginners)**

1. **Open Terminal or Command Prompt**  
- **Linux/Mac**: Open ther terminal.
- **Windows**: If you have Git Bash installed, open Git bash; otherwise, use the Windows Terminal.

2. **Execute SSH Key Generation command**  

Copy the command below and paste it into the terminal:

    ```bash
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```

    **`-t rsa`**: Uses the RSA algorithm.
    
    **`-b 4096`**: Generates a key with a 4096-bit length.
    
    **`-C`**: Add an email to label the key.

3. **Choose the File Location** 
When prompted to choose a location to save the key, presse **Enter** to use the default locadtion. 

4. **Passphrase Setup**
For added security, you can set a passphrase. If you don't want to set one, just press **Enter**

5. **Verify the Public Key**
After completing the steps, you can verify the generated public key using the following command:

    ```bash
    cat ~/.ssh/id_rsa.pub
    ```

ref: [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)

Now, copy the public key and paste it into the form.

**3-2) GPU Instance Setup**

<img src="/images/assets/2024-11-10-20-44-15.png" width="100%" />

You can view a list of available GPUs for rent by clicking the **SEARCH** button on the left sidebar.

However, you cannot rent a GPU server immediately at this stage. You need to choose which Docker image to use for creating the container.

You can customize the Docker image settings through the **EDIT IMAGE & CONFIG…** button in the green box area. However, I will first explain how to explore popular Docker images and settings by clicking the **TEMPLATES** button on the left sidebar.

<img src="/images/assets/2024-11-10-20-46-11.png" width="100%" />

If you click the **Templates** button, you will see a screen like the one above, where Docker images recommended by Vast.ai are displayed.

In addition, you can choose a template based on options like “Recommended” or “Popular” according to your preference.

For this example, I will continue by clicking the **EDIT** button for the PyTorch (cuDNN Runtime) template, which appears first.

<img src="/images/assets/2024-11-10-20-49-33.png" width="100%" />

You’ll be redirected to a webpage where you can configure the Template settings, as shown above.

the **Docker Repository and Environment** section is related to the Docker image.

If the image version you want is different you can specify the version you need. If you prefer a TensorFlow image instaed of PyTorch, simply enter the appropriate Docker image path and version for TensorFlow.

the **Docker Options** section deals with docker create/run options, where you can configure environment variables, ports, and other settings.

the **Launch Mode** section lets you choose how you want to connect—whether via Jupyter Python, SSH, or Docker entrypoint.

Since we will be connecting via SSH, please select Run interactive shell server, SSH.

The **On-start script** section defines which script command will be executed first after the container is started.

Currently, the command written in the template is as follows:

```bash
env >> /etc/environment
mkdir -p ${DATA_DIRECTORY:-/workspace/}
```
The functionality of this is:

1. Add the current list of environment variables to the **/etc/environment** file.

2. Check if the **DATA_DIRECTORY** environment variable is set, and create the directory at the specified path. If the **DATA_DIRECTORY** variable is not set, create the **/workspace/** directory as the default path.

Apart from these, there are other settings like Docker repository authentication and renaming the template. However, these are not necessary for the basic setup, so I will skip them for now.

<img src="/images/assets/2024-11-10-21-01-39.png" width="100%" />

If you scroll down to the bottom, you will find the **Recommended Disk Space** section.

This section defines the disk size, so it’s better to allocate enough space considering the size of the data and deep learning model files.

Once you have finished all the settings, click the **SELECT AND SAVE** button.

<img src="/images/assets/2024-11-10-21-04-56.png" width="100%" />

Then you’ll be redirected to the page where you can select a GPU instance. This time, you’ll notice that **Instance Configuration** box shows the Template and Image set to PyTorch.

Please note that if you want to modify the template, you can click the **EDIT IMAGE & CONFIG…** button and adjust the settings again. For disk space, you can adjust it using the **Disk Space to Allocate** option.

<img src="/images/assets/2024-11-10-21-09-33.png" width="100%" />

I will briefly explain the key points about the GPU instances displayed on the screen:

**1X**: Indicates one GPU (2X: 2 GPUs, 4X: 4 GPUs)

**GTX 1070 TI**: GPU model name

**7.4 TFLOPS**: GPU performance indicator measured in Tera FLOPS.

**Max CUDA**: The maximum supported CUDA version.

**8 GB**: GPU RAM capacity.

**Quebec, CA**: Location of the GPU server(Quebec, Canada)

**↑1685 Mbps**: Internet upload speed

**↓1581 Mbps**: Internet download speed

**$0.109/hr**: Cost per hour (0.109 credits deducted hourly))

For additional details not covered here, you can hover over each section on the Vast.ai website to view a summary of the information.

Once you have selected your desired Template and GPU instance, click the **RENT** button to create the GPU container. (This process takes about 30 seconds to 1 minute.)

Afterward, you can check the status of the GPU server via the **INSTANCES** tab on the left-hand menu.

<img src="/images/assets/2024-11-10-21-22-04.png" width="100%" />
(Image reference: [Vast.ai Docs - instances](https://vast.ai/docs/console/instances))

f you click the **OPEN SSH interface** button, you will see the information for connecting via SSH, as shown above.

For Direct SSH connect, you can find following details:

port: 42677

user: root

IP address: 148.77.2.4

Using this information, I will guide you on how to connect to the Vast.ai GPU container through VS Code.

- ref 
  1. [Vast.ai Docs - instances](https://vast.ai/docs/console/instances)
  2. [Vast.ai Docs - templates](https://vast.ai/docs/console/templates)
  
### 4. Setting Up a Remote Development Environment Using VS Code Remote Extension

To connect via SSH in VS code you need to install the [**Remote - SSH**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) extension.

<img src="/images/assets/2024-11-06-17-39-41.png" width="100%" />

Open VS Code, go to the Extensions menu, and search for "ssh"

Install **Remote-SSH** and **Remote-SSH:Editing Configuration Files**

<img src="/images/assets/2024-11-06-17-57-49.png" width="100%" />

Once the installation is complete, press **ctrl + shift + p** and search for "ssh"

Select **Remote-SSH: Open SSH Configuration File** and open the ``~/user/.ssh/config`` file.

<img src="/images/assets/2024-11-10-21-26-58.png" width="100%" />

In the file, enter the name(e. g., vastai) in the Host field, and the IP address(148.77.2.74) in the HostName field and the Port number(42677) in Port field.

<img src="/images/assets/2024-11-06-17-44-38.png" width="100%" />

After closing the file, press Ctrl + Shift + P again, search for “ssh”, and select Remote-SSH: Connect to Host.

<img src="/images/assets/2024-11-10-21-27-18.png" width="100%" />

The server information you added in the config file will appear.

Click on vastai to connect to the server. Since the SSH key has been registered, you won’t need to enter a password.

<img src="/images/assets/2024-11-10-21-33-02.png" width="100%" />

Once connected, you will see the message “Welcome to your vast.ai container! …” in the shell, confirming that you are successfully logged in as root.

### 5. Verify GPU Status (nvidia-smi)
    
<img src="/images/assets/2024-11-10-21-39-38.png" width="100%" />

You can check if the GPU is set up correctly by running the `nvidia-smi` command in the shell.

If the container is built using an image without the NVIDIA driver installed, the command may not work.
    
### 6. **Stop or Destroy the GPU Server**
    
When you finish using the GPU server, it’s important to either **stop** or **destroy** it to save on costs.

**stop**: Halts the server, reducing costs to disk storage only.

**destroy**: Releases all server computing resources, eliminating costs entirely.

However, be cautious when using **destroy**, as it permanently deletes all data and configurations within the container, making them unrecoverable.

<img src="/images/assets/2024-11-10-21-36-23.png" width="100%" />
(Image reference: [Vast.ai Docs - instances](https://vast.ai/docs/console/instances))

To **stop** the server, click the black box icon highlighted in the purple circle.

To **destroy** the server, click the trash bin icon highlighted in the red circle

<img src="/images/assets/2024-11-10-21-37-21.png" width="100%" />
(Image reference: [Vast.ai Docs - instances](https://vast.ai/docs/console/instances))

If you want to reactivate a stopped server, click the play button highlighted in the red circle.

