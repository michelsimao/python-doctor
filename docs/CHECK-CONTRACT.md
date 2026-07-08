# Python Doctor

# Check Contract

Este documento define o contrato que todos os módulos localizados em `checks/` devem seguir.

O objetivo é garantir que todas as auditorias produzam resultados consistentes, reutilizáveis e independentes do formato de saída.

Nenhum check deve escrever diretamente no terminal, gerar arquivos ou tomar decisões destrutivas.

Sua única responsabilidade é observar o ambiente e produzir um resultado estruturado.

---

# Filosofia

Um check nunca decide.

Um check nunca modifica o sistema.

Um check nunca pergunta nada ao usuário.

Um check apenas:

- coleta informações;
- analisa evidências;
- classifica o resultado;
- produz recomendações.

---

# Estrutura de um Check

Todo check deve possuir uma única responsabilidade.

Exemplos:

- verificar Python
- verificar pip
- verificar pipx
- verificar cache
- verificar ambientes virtuais

Nunca misturar responsabilidades.

Exemplo incorreto:

```
python.sh

✔ verifica Python

✔ verifica pip

✔ verifica Poetry
```

Cada auditoria deve possuir seu próprio módulo.

---

# Estrutura do Resultado

Todo check deverá produzir um objeto contendo os seguintes campos.

| Campo | Obrigatório | Descrição |
|--------|-------------|-----------|
| id | Sim | Identificador único do check |
| title | Sim | Nome apresentado ao usuário |
| status | Sim | Resultado da auditoria |
| risk | Sim | Classificação de risco |
| summary | Sim | Resumo em uma frase |
| details | Sim | Informações técnicas |
| recommendation | Sim | Ação recomendada |

---

# ID

Identificador único.

Exemplos:

```
python

pip

pipx

uv

cache

venvs
```

Nunca utilizar espaços.

Nunca utilizar acentos.

Sempre utilizar letras minúsculas.

---

# Title

Nome amigável.

Exemplo:

```
Python

Pip

Poetry

Virtual Environments
```

---

# Status

Representa o resultado da auditoria.

Valores permitidos:

| Valor | Significado |
|--------|-------------|
| PASS | Tudo correto |
| INFO | Informação relevante |
| WARN | Atenção necessária |
| FAIL | Problema encontrado |
| SKIP | Auditoria não executada |

---

# Risk

Representa o impacto de uma possível ação.

Valores permitidos:

| Valor | Significado |
|--------|-------------|
| INFO | Nenhum risco |
| LOW | Baixo risco |
| MEDIUM | Requer análise |
| HIGH | Alto risco |

---

# Summary

Resumo objetivo.

Exemplo:

```
Python instalado corretamente.
```

ou

```
Poetry não encontrado.
```

A leitura do resumo deve ser suficiente para entender o resultado da auditoria.

---

# Details

Informações técnicas.

Exemplo:

```
Versão:

3.12.3

Executável:

/usr/bin/python3

Gerenciado por:

APT
```

Não há limite de linhas.

Quanto mais evidências forem apresentadas, melhor.

---

# Recommendation

Ação sugerida.

Exemplo:

```
Nenhuma ação necessária.
```

ou

```
Instale o pipx para isolar ferramentas CLI do ambiente global.

Comando sugerido:

sudo apt install pipx
```

Toda recomendação deve possuir justificativa técnica.

---

# Regras Obrigatórias

Todo check deve:

✔ ser idempotente

✔ ser determinístico

✔ não alterar o sistema

✔ não criar arquivos

✔ não remover arquivos

✔ não utilizar sudo

✔ não escrever diretamente no terminal

✔ não perguntar nada ao usuário

✔ produzir exatamente um resultado

---

# Tratamento de Erros

Erros internos da auditoria não devem ser confundidos com problemas encontrados no ambiente.

Exemplo:

```
Poetry não instalado.
```

Resultado:

```
STATUS = INFO
```

ou

```
STATUS = WARN
```

Dependendo do contexto.

---

Já:

```
Permission denied
```

não representa um problema do ambiente.

Representa uma falha na auditoria.

Neste caso o check deverá retornar erro para o dispatcher.

---

# Independência

Todo check deve funcionar de maneira isolada.

Nenhum check poderá depender da execução de outro.

Exemplo:

```
python.sh
```

não poderá depender de

```
pip.sh
```

A coordenação das auditorias é responsabilidade exclusiva do comando `doctor`.

---

# Renderização

Checks nunca produzem saída formatada.

A apresentação dos resultados pertence exclusivamente aos renderizadores.

Isso permite gerar:

- Terminal
- Markdown
- HTML
- JSON (futuro)

sem modificar os checks.

---

# Objetivo

Um check é uma unidade de auditoria.

Sua missão é produzir um resultado confiável, reproduzível e independente da forma como esse resultado será apresentado ao usuário.