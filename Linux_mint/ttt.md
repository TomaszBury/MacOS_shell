[Mint](https://grok.com/share/c2hhcmQtMw%3D%3D_919d534c-bc4f-42f1-a3f8-b49a7f264d3f)

```bash
sudo apt install openssh-server
sudo systemctl enable --now ssh
sudo systemctl status ssh
```

```bash
sudo systemctl set-default multi-user.target
```

```bash
sudo systemctl set-default graphical.target
sudo reboot
```

```bash
sudo reboot
```

#FTP
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install vsftpd -y
vsftpd --version
sudo nano /etc/vsftpd.conf
sudo systemctl start vsftpd

```

```bash
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
```

#add FTP
```bash
sudo adduser ftpuser
sudo chmod -R 755 /home/ftpuser
cd /home/ftpuser
rm -rf /home/ftpuser/*
```