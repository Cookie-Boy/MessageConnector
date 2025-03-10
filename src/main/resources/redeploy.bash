#!/bin/bash

sudo echo "[redeploy.bash] Начало работы."

TEMP_PATH="temp"
APPS_PATH="apps"
CONNECTOR_NAME="messageconnector"

while [ -d "../${APPS_PATH}/${CONNECTOR_NAME}" ]; do
  echo "[redeploy.bash] Коннектор всё ещё запущен, ожидаем завершения..."
  sleep 2
done

echo "[redeploy.bash] Выходим из папки temp (cd ..)"
cd ..

echo "[redeploy.bash] Создаем директорию '${APPS_PATH}/${CONNECTOR_NAME}'"
mkdir ${APPS_PATH}/${CONNECTOR_NAME}

echo "[redeploy.bash] Выдаем права на папку '${APPS_PATH}/${CONNECTOR_NAME}'"
chmod 755 ${APPS_PATH}/${CONNECTOR_NAME} || { echo "[redeploy.bash] Ошибка прав доступа для '${APPS_PATH}/${CONNECTOR_NAME}'"; exit 1; }

echo "[redeploy.bash] Перемещаем файлы и папки коннектора..."
mv -f ${TEMP_PATH}/${CONNECTOR_NAME}/* ${TEMP_PATH}/${CONNECTOR_NAME}/.* ${APPS_PATH}/${CONNECTOR_NAME}/ 2>/dev/null

echo "[redeploy.bash] Удаляем '${TEMP_PATH}/${CONNECTOR_NAME}'"
rm -rf ${TEMP_PATH}/${CONNECTOR_NAME}

echo "[redeploy.bash] Готово! Коннектор перемещен."