FROM acinq/phoenixd:latest

USER root

RUN printf '#!/bin/sh\nchown -R phoenix:phoenix /phoenix/.phoenix 2>/dev/null || true\nexec su phoenix -s /bin/sh -c "/phoenix/phoenixd --http-bind-ip 0.0.0.0 --http-password rudisln2024"\n' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
