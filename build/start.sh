#!/bin/sh

# SSH-Schlüssel generieren, falls nicht vorhanden
if [ ! -f id_ed25519 ]; then
    ssh-keygen -t ed25519 -f id_ed25519 -q -N ''
    echo 'SSH keys generated.'
else
    echo 'SSH keys already exist.'
fi

# Setze Berechtigungen für SSH-Dateien
chmod 700 .
chmod 600 id_ed25519
chmod 644 id_ed25519.pub

# Stelle sicher, dass die Datei known_hosts existiert
touch known_hosts
chmod 644 known_hosts

# SSH-Config neu schreiben
echo 'Host *' > config
echo '    ServerAliveInterval 60' >> config
echo '    ServerAliveCountMax 240' >> config
echo '    StrictHostKeyChecking no' >> config

# Falls die Umgebungsvariablen gesetzt sind, Host-Eintrag hinzufügen
if [ -n "$SSH_HOST" ] && [ -n "$SSH_HOSTNAME" ] && [ -n "$SSH_USER" ]; then
    echo "" >> config
    echo "Host $SSH_HOST" >> config
    echo "    Hostname $SSH_HOSTNAME" >> config
    echo "    User $SSH_USER" >> config
    echo "Custom SSH host entry added."
fi

# Setze Berechtigungen für die Config-Datei
chmod 600 config

# Zeige den öffentlichen Schlüssel
echo 'Public SSH key:'
cat id_ed25519.pub