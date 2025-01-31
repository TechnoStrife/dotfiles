{ config, pkgs, inputs, username, ... }:

{
  # create a oneshot job to authenticate to Tailscale
  systemd.services.tailscale-cert = {
    description = "Automatic certificate renewal with Tailscale";

    # make sure tailscale is running before trying to connect to tailscale
    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    startAt = "*-*-* 01:11:11";

    # have the job run this shell script
    script = with pkgs; ''
      # wait for tailscaled to settle
      set -e
      sleep 10

      KEY=/etc/ssl/private/tailscale.key
      CERT=/etc/ssl/certs/tailscale.crt
      mkdir -p /etc/ssl/private /etc/ssl/certs

      if [ -f "$KEY" ]; then
        ftime=`stat -c %Y "$KEY"`
        ctime=`date +%s`
        diff=$(( (ctime - ftime) / 86400 ))
        if [ "$diff" -lt 60 ]; then
          echo "Skipping renewal. Days since last renewal: $diff"
          exit 0
        fi
        echo "Running tailscale certificate renewal: $diff days since last renewal"
      else
        echo "Running tailscale certificate renewal: $KEY is absent"
      fi

      domain=$(${tailscale}/bin/tailscale status --json | ${jq}/bin/jq -r ".CertDomains[0]")
      echo "Renewing for domain: $domain"

      ${tailscale}/bin/tailscale cert --cert-file "$CERT" --key-file "$KEY" "$domain"
      chown nginx:nginx "$CERT" "$KEY"
      chmod 440 "$CERT" "$KEY"
      echo "Done"
    '';
  };
}
