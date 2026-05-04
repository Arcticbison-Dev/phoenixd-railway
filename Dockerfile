FROM acinq/phoenixd:latest

USER root

RUN printf '#!/bin/sh\n\
chown -R phoenix:phoenix /phoenix/.phoenix 2>/dev/null || true\n\
mkdir -p /phoenix/.phoenix\n\
chown phoenix:phoenix /phoenix/.phoenix\n\
touch /phoenix/.phoenix/phoenix.conf\n\
grep -v "^http.password=" /phoenix/.phoenix/phoenix.conf > /tmp/phconf.tmp\n\
echo "http.password=rudisln2024" >> /tmp/phconf.tmp\n\
cp /tmp/phconf.tmp /phoenix/.phoenix/phoenix.conf\n\
chown phoenix:phoenix /phoenix/.phoenix/phoenix.conf\n\
exec su phoenix -s /bin/sh -c "/phoenix/phoenixd --http-bind-ip 0.0.0.0"\n\
' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
