### Hexlet tests and linter status:
[![Actions Status](https://github.com/vladlen-li/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/vladlen-li/devops-for-programmers-project-77/actions)

# 🧰 Infrastructure & Monitoring Automation

Этот проект автоматизирует развёртывание, настройку и мониторинг веб-приложения с использованием:

    Terraform — управление инфраструктурой (Google Cloud, Datadog)

    Ansible — конфигурация виртуальных машин, установка и настройка Datadog Agent

    Datadog — мониторинг приложения через локальный агент (http_check) и глобальные Synthetic проверки

    dnsmasq — локальное доменное разрешение Terraform-инстансов по алиасам

    Upmon — глобальный мониторинг доступности из разных регионов

    Ansible Vault — безопасное хранение чувствительных данных (ключей, токенов)

## Требования
| Компонент         | Версия или пакет                     | Обязательно | Назначение                               |
| ----------------- | ------------------------------------ | ----------- | ---------------------------------------- |
| `Terraform`       | ≥ 1.5.0                              | ✅ Да        | Инфраструктура (GCP, Datadog)            |
| `Ansible`         | ≥ 2.10                               | ✅ Да        | Конфигурация VM и Datadog Agent          |
| `python3` + `pip` | с `passlib`, `PyYAML` и др           | ✅ Да        | Для Ansible и Vault                      |
| `dnsmasq`         | `dnsmasq` пакет                      | 🔁 Нет      | (опционально) Локальные DNS-алиасы к VM  |


## 🚀 Быстрый старт

1. Подготовьте `.env` файл

Создайте файл `.env` в корне проекта со следующим содержимым:

```dotenv
DATABASE_NAME=name
DATABASE_HOST=127.0.0.1
DATABASE_PORT=1234
REDMINE_EXTERNAL_PORT=80
```

2. Подготовте файл с ключом шифрования для ansible-vault
Создайте скрипт `get_vault_key`, который будет выводить ключ шифрования

```bash
#!/bin/bash
echo "here_is_your_key"
```

3. ✅ Установи зависимости

```bash
make ansible-dependencies
```

4. 🏗️ Создай инфраструктуру (GCP, Datadog, VM, Load Balancer)

```bash
make build-infra
```
5. 🧰 Настрой удалённые машины и задеплой приложение

```bash
make deploy
```

⚙️ Также автоматически обновит локальные DNS-записи, в случае если установлен dnsmasq

## 📌 Команды Makefile

| Цель                          | Описание                                |
| ----------------------------- | --------------------------------------- |
| `make build-infra`            | Создать инфраструктуру и обновить DNS   |
| `make deploy`                 | Установить Datadog Agent, настроить VM  |
| `make destroy`                | Удалить Ansible-конфигурации            |
| `make destroy-terraform`      | Удалить инфраструктуру                  |
| `make update-vms-dns-records` | Обновить dnsmasq по output’ам Terraform |
| `make edit-secrets`           | Редактировать зашифрованные переменные  |
