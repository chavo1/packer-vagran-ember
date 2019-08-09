mkdir -p /etc/dpkg/dpkg.cfg.d
cat >/etc/dpkg/dpkg.cfg.d/01_nodoc <<EOF
path-exclude /usr/share/doc/*
path-include /usr/share/doc/*/copyright
path-exclude /usr/share/man/*
path-exclude /usr/share/groff/*
path-exclude /usr/share/info/*
path-exclude /usr/share/lintian/*
path-exclude /usr/share/linda/*
EOF

export DEBIAN_FRONTEND=noninteractive
export APTARGS="-qq -o=Dpkg::Use-Pty=0"

apt-get clean ${APTARGS}
apt-get update ${APTARGS}

apt-get upgrade -y ${APTARGS}
apt-get dist-upgrade -y ${APTARGS}

# Update to the latest kernel
apt-get install -y linux-generic linux-image-generic ${APTARGS}

# build-essential
apt-get install -y build-essential libssl-dev --no-install-recommends ${APTARGS}

# install curl vim
apt-get install -y curl vim ${APTARGS}

# Install nodejs
curl -sL https://deb.nodesource.com/setup_12.x | bash -

apt-get update ${APTARGS}
apt-get install -y nodejs ${APTARGS}

# Install ember v3.11.0
npm install -g ember-cli@3.11.0

####################################
#   Ember as a systemd Unit file   #
####################################
cat <<EOF > /etc/systemd/system/ember.service
[Unit]
Description=Ember CLI
After=network-online.target

[Service]
Restart=on-failure
WorkingDirectory=/vagrant/www/
ExecStart=/usr/lib/node_modules/ember-cli/bin/ember serve /vagrant/www/app/app.js

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload

# Hide Ubuntu splash screen during OS Boot, so you can see if the boot hangs
apt-get remove -y plymouth-theme-ubuntu-text
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
update-grub

# Reboot with the new kernel
shutdown -r now
