#!/bin/sh

if [ ! -f id_ed25519 ]; then
    ssh-keygen -t ed25519 -f id_ed25519 -q -N ''

    echo 'Host *' > config
    echo '    ServerAliveInterval 60' >> config
    echo '    ServerAliveCountMax 240' >> config
    echo '    StrictHostKeyChecking no' >> config

    echo 'SSH keys generated.'
else
    echo 'SSH keys already exist.'
fi

chmod 700 .
chmod 600 id_ed25519
chmod 644 id_ed25519.pub
chmod 600 config

echo 'Public SSH key:'
cat id_ed25519.pub
