# if this is the very first time the appliance is starting
if [ ! -f /home/jharvard/.config/autostart/initialized ]
then
    # get virtualization platform
    declare vmm=$(sudo virt-what)

    # install tools for specific hypervisor
    if [ "$vmm" = 'vmware' ]
    then
        sudo /vmware-tools/vmware-install.pl -d
    elif [ "$vmm" = 'vbox' ]
    then
        sudo sh /vbox/VBoxLinuxAdditions.run
    elif [ "$vmm" = 'parallels' ]
    then
        sudo sh -c "cd /parallels && /parallels/install --install-unattended"
    fi

    # Remove the Install Appliance50 from Live CD
    rm -f /home/jharvard/Desktop/ubiquity.desktop

    # clean up hypervisor tools
    sudo rm -rf /vmware-tools/
    sudo rm -rf /vbox/
    sudo rm -rf /parallels/

    # set chrome as default browser
    xdg-settings set default-web-browser google-chrome.desktop

    # change /etc/hostname to "appliance"
    sudo sh -c "echo 'appliance' > /etc/hostname"
    sudo sed -i 's/ubuntu/appliance/g' /etc/hosts
    

    # first boot has completed
    touch /home/jharvard/.config/autostart/initialized
else
    # generate id
    sudo /usr/bin/uuid -v 4 > /etc/id50

    register50
fi
