---
title:  "[GPU Cloud Setting] Paperspace setting"
excerpt: "How to setting GPU Virtual Machines(VMs) using Paperspace."
lang: en
lang-ref: paperspace-setup
permalink: /set_up/paperspace-setup/
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
image: "/assets/images/paperspace-setup.jpg"  # 포스트 대표 이미지 경로
share: true        # 소셜 미디어 공유 버튼 활성화
comments: true     # 댓글 기능 활성화
related:
  - "[GPU Cloud Setting] (General) Why we use and How to setting"  # 관련 포스트 제목
  - "[GPU Cloud Setting] Vast.ai setting"  
date: 2024-11-06
last_modified_at: 2022-11-09
redirect_from: 
  - /set_up/gpu-cloud-setup/  # 이전 포스트에서 리디렉션
---

cf. It may be difficult to follow the exact steps below, as the Paperspace UI might change over time. However, the overall process of renting a GPU Virtual Machines (VMs) will remain similar, so you can still easily rent one by referring to the steps below.

### 1. Sign Up and Log In

If you sign up via social login (e.g., Google, GitHub, etc.), you'll go through the following steps:

1. Verify your smartphone
2. Verify your name
3. Choose a product (`gradient` or `CORE`)
4. Fill out a brief survey (e.g., job)

There are two product options: `gradient` and `CORE`.

`gradient` is a platform that simplifies the development, training, and deployment of machine learning and deep learning models.
`CORE` refers to Paperspace's Virtual Machines (VMs), providing cloud computing resources such as GPU, CPU, storage, networking, and more.
Since we're focusing on Paperspace's VM, choose `CORE`.

**cf.** You can change between `gradient` and `CORE` later when choosing which server to rent, so there's no need to worry about making the wrong choice now.


### 2. Enroll The Credit Card

<img src="/images/assets/2024-11-06-17-53-41.png" width="100%"/>

After signing up, you should see a screen similar to the one above.

On the top left, you’ll see the logo representing the `CORE` service, and on the middle left of the screen, there is a `CREATE A MACHINE` button.

(If the screen looks different, the logo will likely show `gradient`. You can switch it to `CORE` using the toggle.)

Click the `CREATE A MACHINE` button to rent a GPU.
    
<img src="/images/assets/2024-11-06-17-54-07.png" width="100%" />

After clicking `CREATE A MACHINE`, a new screen for selecting a machine appears, as shown above.

Since we haven’t registered a credit card yet, a message in a yellow box indicates that a payment method is required.
Click the `ADD A CREDIT CARD` button to register your credit card.

<img src="/images/assets/2024-11-06-17-54-17.png" width="100%" />

After clicking the `ADD A CREDIT CARD` button, a pop-up screen appears for entering your personal and card information,
as shown above.

Fill out the form with your personal detilas and credit card information.

<img src="/images/assets/2024-11-06-17-54-27.png" width="100%" />
    
If you register the card, the yellow box requesting a payment method should disappear.

### 3. GPU Instance Setup and SSH Key Registration 
**3-1) GPU, OS, Disk Setup**
    
After clicking the `Select a machine` toggle, choose your desired machine from the options below.

<img src="/images/assets/2024-11-06-17-54-40.png" width="100%" />

There are four choices: GPU, Multi-GPU, CPU, and All.

**GPU**: Rent a single GPU

**Multi-GPU**: Rent multiple GPUs simultaneously

**CPU**: Rent a server with only CPU resources, no GPU

**All**: A combination of all three options above

In the GPU option, you’ll see the model name, hourly rate (in USD), and how many cores in CPU.

Select your preferred GPU specifications from these options, then proceed to the next step.

<img src="/images/assets/2024-11-06-17-55-15.png" width="100%" />

Ah-ha! We were about to proceed to the next step, but it turns out we need approval from Paperspace to rent a V100 GPU server.
Please note that this requirement applies not only to the V100 but also to other GPUs (including Multi-GPU setups).

(Another note: Receiving approval once does not grant access to all GPU types. Since approval requests are grouped by GPU types, you’ll need to request access for each group if you want to use another GPU types.)

Select the **How do you intend to use this machine?** text box, type your intended use for the GPU server, and click the ``REQUEST MACHINE TYPE`` button.

(If you don’t provide a detailed explanation, your request may be denied, or additional information may be requested.)

<img src="/images/assets/2024-11-06-17-55-27.png" width="100%" />  

According to the information above, approval usually takes 1–2 business days.

The approval result will be sent via email. In my case, it took about one day to receive approval.

<img src="/images/assets/2024-11-06-17-55-34.png" width="100%" />

After receiving approval, you can now select a GPU machine.

First, choose a GPU model as before, considering both the specifications and price.

**OS Template**

Next, choose an OS template. Currently, Paperspace offers Ubuntu, Windows, and CentOS.
    
**Disk size**

Then, select the disk size. It’s best to choose a capacity large enough to accommodate both your data and deep learning model files.

Please note that the cost of the disk is also included in the total price, so choose accordingly.

**Machine name**    

Next, you’ll need to name the machine. You can name it according to your preference or use the project name.

**3-2) Network Setup**

<img src="/images/assets/2024-11-06-17-55-42.png" width="100%" />

First, **Region** refers to the location of the server you want to rent. Generally, the closer the server is to your location, the better the network connection will be. So, choose a region that is close to you for optimal performance.

**Public IP** setup determines whether you'll need internet access. You can select "None" if you don’t need an internet environment. However, keep in mind that you won't be able to access GitHub or download/upload data through the internet.

The difference between **Dynamic** and **Static IP** is whether you need to fix the **Public IP**. If you don't need to assign a static IP, you can choose "Dynamic."

They also offer a **Private Network** option, but I will skip that for now.

**3-3) Authentication and Access**

In the `Authentication and Access` setup, you will register your local computer's SSH key to the GPU server.

<img src="/images/assets/2024-11-06-17-55-53.png" width="100%" />

(ref: [Paperspace > Accounts & Teams > Add SSH Keys](https://docs.digitalocean.com/products/paperspace/accounts-and-teams/add-ssh-keys/))

- **If you already have an SSH key**: Copy the public key, paste it, and give the SSH key a name.

- **If you don't haev an SSH key**: Follow the SSH key generation guide below to create a new SSH key and register the public key.

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

Now, copy the public key and paste it into the `Authentication and Access` form.

**3-4) Snapshots Setup(ref: [Paperspace snapshot](https://docs.digitalocean.com/products/paperspace/machines/how-to/manage-snapshots/))**

<img src="/images/assets/2024-11-06-17-56-05.png" width="100%" />

Next is the `Snapshots` setup. `Snapshots` is a backup feature that saves the current state of the server (including environment, data, etc.). It is primarily used to prepare for contingencies, such as unexpected server downtime.

You can configure the snapshot frequency and specify how many snapshots to store.

**3-5) Starting State**

<img src="/images/assets/2024-11-06-17-56-12.png" width="100%" />
    
Next is the `Starting State`. You can choose whether to start the machine immediately after creation or start it manually later.

The hourly price (Price summary) is displayed below the `Starting State`, and the machine will be created according to your settings when you click the `CREATE MACHINE` button.

<img src="/images/assets/2024-11-06-17-56-21.png" width="100%" />

Then you can see the machine is setting up like the above in `Machines` tab

**3-6) Verify GPU Instance SSH Information**
    
<img src="/images/assets/2024-11-06-17-57-03.png" width="100%" />

When you click the Connect button, the host name (in this case, "paperspace") and IP address (the number after @) will be provided for SSH access.

You can use this information to connect via SSH in your terminal or IDE.

### 4. Setting Up a Remote Development Environment Using VS Code Remote Extension

To connect via SSH in VS code you need to install the [**Remote - SSH**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) extension.

<img src="/images/assets/2024-11-06-17-39-41.png" width="100%" />

Open VS Code, go to the Extensions menu, and search for "ssh"

Install **Remote-SSH** and **Remote-SSH:Editing Configuration Files**

<img src="/images/assets/2024-11-06-17-57-49.png" width="100%" />

Once the installation is complete, press **ctrl + shift + p** and search for "ssh"

Select **Remote-SSH: Open SSH Configuration File** and open the ``~/user/.ssh/config`` file.

<img src="/images/assets/2024-11-06-17-58-16.png" width="100%" />

In the file, enter "paperspace" in the **Host** field, and the IP address in the **HostName** field.

<img src="/images/assets/2024-11-06-17-44-38.png" width="100%" />

After closing the file, press **Ctrl + Shift + P** again, search for "ssh", and select **Remote-SSH: Connect to Host.**

<img src="/images/assets/2024-11-06-17-58-34.png" width="100%" />

The server information you added in the config file will appear.

Click on **paperspace** to connect to the server. Since the SSH key has been registered, you won’t need to enter a password.

<img src="/images/assets/2024-11-06-17-45-17.png" width="100%" />

Once connected, you can confirm that the shell's host is set to **paperspace**


### 5. Verify GPU Status (`nvidia-smi`)
    
<img src="/images/assets/2024-11-06-17-58-45.png" width="100%" />

You can check if the GPU is set up correctly by running the `nvidia-smi` command in the shell.
Note: Since I rented an RTX 4000, I can confirm that the RTX 4000 is assigned to me.

After this, you'll need to set up the environment for your experiment or development. Since Paperspace only sets up the operating system on a virtual machine (VM) and does not use a Docker image to build the server, you'll need to configure the environment manually. This is a downside of using Paperspace (CORE).

However, the advantage is that it offers more flexibility compared to container-based cloud services.

### 6. Shutting Down or Deactivating the GPU Server

When you finish using the GPU server, it’s important to either **shutdown** or **deactivate** it to save on costs.

**Shut Down**: Shutting down the server stops GPU usage, reducing costs.

**Deactivate**: Deactivating the server releases all computing resources, so no further costs will be incurred.

However, be cautious when choosing **deactivate**, as it permanently deletes the server. You won’t be able to recover any work done unless you've created a **template** beforehand.

- **Shutdown**
    
**Metohd 1: Using the Paperspace UI**

<img src="/images/assets/2024-11-06-18-00-59.png" width="75%" height="65%" />

Click the `...` button in the upper right corner of the Machine, then select the `Shutdown` button.


**Metohd 2: Using the shell**

in the paperspace shell,

```bash
sudo shutdown now
```

enter the shutdown command abvoe to turn off the server. (Be careful not to enter this command in your local shell.)

After shutting down, the server's status will change to "off", as shown below

<img src="/images/assets/2024-11-06-18-01-07.png" width="65%" height="50%" />
    
- **Deactivate**
    
<img src="/images/assets/2024-11-06-18-01-17.png" width="65%" height="50%" />

Remove the server by clicking the `Deactivate` button

### 7. **Creating and using Templates**

**7-1) Why Templates are Useful**

If you need to change the SSH key or adjust disk capacity after creating a Machine, you’ll have to recreate the Machine, which can be cumbersome as it requires redoing all development environment setup from scratch. To solve this, Paperspace CORE provides a `template` feature. By using a `template`, you can transfer your server environment instantly without needing to reconfigure your development setup.

<img src="/images/assets/2024-11-06-17-59-12.png" width="65%" height="50%" />

**7-2) How to Create Template**

First, shutdown the server to prepare it for creating a template.

Next, click on the area of the Machine card, excluding the `CONNECT` and `...` buttons, to access the Machine details page.

<img src="/images/assets/2024-11-06-19-57-32.png" width="65%" />

On the right side of the screen, you will see options for **Detail**, **Snapshots**, **Templates**, **Logs**, and **Setting**

Click the **Templates** button on the right side.

<img src="/images/assets/2024-11-06-17-59-24.png" width="100%" />

Then you will see the `CREATE TEMPLATE` button on the left. Click this button.

<img src="/images/assets/2024-11-06-17-59-32.png" width="80%" />

Enter a name for the Template and click `CREATE TEMPLATE` to save the current state of the VM.

<img src="/images/assets/2024-11-06-18-00-33.png" width="100%" />

If you want to create a Machine again using a **Template**, go to the **Templates** tab, click the `...` button on the desired Template, and select `Create machine from template`.

<img src="/images/assets/2024-11-06-18-00-41.png" width="100%" />

In the `OS Template` section, confirm that the correct template is selected. Then, reconfigure the Machine settings as needed and click `CREATE MACHINE` to obtain a Machine with the same setup as before.

**7-3) TIP: Reduce Costs with Templates**

Since `Templates` only incur disk storage costs based on their size, you can save costs by creating a Template to store your server settings if you need to pause the project for an extended period. This approach helps reduce expenses and saves time on environment setup when resuming work.
