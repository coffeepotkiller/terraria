I followed this handy Linode guide to setup Terraria on a Linux server as a systemd service:
https://www.linode.com/docs/guides/host-a-terraria-server-on-your-linode/
<br/>NOTE: They have you run the server from the root account which I would not recommend, I suggest using a separate user account instead for security reasons.

Here are a few bash scripts I made to further automate managing this server:

```update-terraria-server.sh```: They release updates to the Terraria client and server software every 1-2 weeks usually. It can be kind of a pain to update the Terraria server each time so I made this janky script to streamline the update process. You would just need to update the directory variables depending where you keep your server files.

```backup-terraria-world.sh```: On my server I setup [rclone](https://rclone.org/) with Google Drive so that I can easily backup my world. I setup this script as a cronjob to run once a day.

