## Step 1
- Setting up VirtualBox Arch, vboxdrv module was not built successfully. Same with vboxnetadp and vboxnetflt (for networking)
- Had to change ip from 192.168.33.10 to 192.168.56.9 since that was the alloted range (192.168.56.0/21)

## Step 3
- The mounted volume was mounted in the system root, not in the user directory
- The service yaml selector naming. It does not uses matchLabels
