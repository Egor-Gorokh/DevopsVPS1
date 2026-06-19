#!/bin/bash
set -e
 
DEPLOY_DIR="/var/www/myapp"
 
# ── Подключение ───────────────────────────────────────────
echo ""
read -p "  IP сервера: " SERVER_IP
[[ -z "$SERVER_IP" ]] && echo "  Ошибка: IP не указан" && exit 1
 
read -p "  Пользователь [deploy]: " SERVER_USER
SERVER_USER="${SERVER_USER:-deploy}"
 
read -p "  SSH-ключ [~/.ssh/id_ed25519]: " SSH_KEY
SSH_KEY="${SSH_KEY:-~/.ssh/id_ed25519}"
 
SERVER="${SERVER_USER}@${SERVER_IP}"
SSH_OPTS="-i ${SSH_KEY}"
 
# ── Что деплоить ──────────────────────────────────────────
echo ""
echo "  Что деплоить?"
echo "   1) frontend"
echo "   2) backend"
echo "   3) frontend + backend"
echo ""
read -p "  Выбор [1/2/3]: " CHOICE
 
case "$CHOICE" in
  1) PULL_DIRS="frontend";         COMPOSE_SVC="frontend" ;;
  2) PULL_DIRS="backend";          COMPOSE_SVC="backend"  ;;
  3) PULL_DIRS="frontend backend"; COMPOSE_SVC=""         ;;
  *) echo "  Неверный выбор" && exit 1 ;;
esac
 
echo ""
echo "🚀 Деплой → ${SERVER}"
echo ""
 
# ── Выполняем на сервере ──────────────────────────────────
ssh $SSH_OPTS "$SERVER" "
  set -e
  for dir in $PULL_DIRS; do
    echo \"→ git pull \$dir...\"
    cd ${DEPLOY_DIR}/\$dir && git pull origin main
  done
  echo '→ Пересобираем контейнеры...'
  cd ${DEPLOY_DIR} && docker compose up --build -d ${COMPOSE_SVC}
  docker compose ps
"
 
echo ""
echo "✅ Готово"
