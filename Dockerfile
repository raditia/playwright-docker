ARG PLAYWRIGHT_VERSION=1.54.1
FROM mcr.microsoft.com/playwright:v${PLAYWRIGHT_VERSION}-jammy

ARG PNPM_VERSION=9.15.0
RUN npm install -g pnpm@${PNPM_VERSION}

WORKDIR /app

# Default: run as a Playwright remote browser server
# Tests on the host connect via ws://localhost:<PORT>
EXPOSE 3000
CMD ["npx", "playwright", "run-server", "--port", "3000", "--host", "0.0.0.0"]
