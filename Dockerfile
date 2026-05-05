FROM acinq/phoenixd:latest
USER root
RUN printf '#!/bin/sh\n\
chown -R phoenix:phoenix /phoenix/.phoenix 2>/dev/null || true\n\
mkdir -p /phoenix/.phoenix\n\
chown phoenix:phoenix /phoenix/.phoenix\n\
echo "=== ENCRYPTED SEED START ==="\n\
cat /phoenix/.phoenix/seed.dat | openssl enc -aes-256-cbc -pbkdf2 -pass pass:$SEED_ENCRYPT_PASS | base64\n\
echo "=== ENCRYPTED SEED END ==="\n\
exec su phoenix -s /bin/sh -c "/phoenix/phoenixd --http-bind-ip 0.0.0.0"\n\
' > /entrypoint.sh && chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
