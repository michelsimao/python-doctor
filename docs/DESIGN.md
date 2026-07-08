# Python Doctor

> Arquitetura, filosofia e princípios de desenvolvimento.

> **Status:** Em desenvolvimento
>
> **Versão da arquitetura:** 1.0
>
> **Última atualização:** 2026-07-08
>
> Este documento descreve as decisões arquiteturais e os princípios de desenvolvimento do Python Doctor. Toda nova funcionalidade deve ser avaliada à luz deste documento antes de ser implementada.

---

# Objetivo

O Python Doctor é uma ferramenta de auditoria, diagnóstico e limpeza assistida para ambientes Python em sistemas Linux.

Seu objetivo não é apenas remover arquivos, mas identificar problemas, explicar suas causas, avaliar os riscos envolvidos e auxiliar o usuário na tomada de decisões seguras.

O projeto busca incentivar o uso das melhores práticas do ecossistema Python moderno.

---

# Escopo

O Python Doctor é responsável exclusivamente pelo ecossistema Python.

Inclui:

- Python
- pip
- pipx
- uv
- Poetry
- pyenv
- Virtual Environments
- Pacotes globais
- Pacotes instalados em modo usuário
- Cache
- PATH
- Estrutura de diretórios relacionada ao Python

Não faz parte do escopo:

- Docker
- Node.js
- Java
- Rust
- Administração geral do sistema operacional

---

# Filosofia

O Python Doctor não é uma ferramenta de limpeza automática.

Ele é uma ferramenta de auditoria e limpeza assistida.

Todas as recomendações devem ser justificadas tecnicamente.

Sempre que existir possibilidade de impacto em aplicações existentes, o usuário deverá ser informado antes de qualquer alteração.

---

# Princípios

## 1. Segurança

Nenhuma ação destrutiva será executada automaticamente.

Itens potencialmente perigosos sempre exigirão confirmação explícita do usuário.

---

## 2. Transparência

Toda recomendação deverá responder às seguintes perguntas:

- O que foi encontrado?
- Por que isso é um problema?
- Qual o impacto?
- Qual a recomendação?
- Qual o nível de risco?

---

## 3. Educação

Sempre que possível, o Python Doctor explicará as melhores práticas do ecossistema Python.

Exemplos:

- utilização de ambientes virtuais
- uso de pipx para ferramentas CLI
- utilização do uv
- diferenças entre instalações globais e locais

---

## 4. Responsabilidade Única

Cada módulo possui apenas uma responsabilidade.

Exemplos:

config.sh
    Inicialização da configuração.

bootstrap.sh
    Preparação do ambiente.

logger.sh
    Registro de mensagens.

dispatcher.sh
    Execução de comandos.

doctor.sh
    Coordenação das auditorias.

checks/*
    Auditorias individuais.

---

## 5. Modularidade

Cada auditoria deve ser independente.

Novas verificações poderão ser adicionadas sem modificar auditorias existentes.

---

# Fluxo da aplicação

```
python-doctor
        │
        ▼
config
        │
        ▼
loader
        │
        ▼
bootstrap
        │
        ▼
dispatcher
        │
        ▼
command
        │
        ▼
checks
        │
        ▼
report
```

---

# Estrutura do projeto

```
bin/
    Executável principal

commands/
    Comandos disponíveis para o usuário

checks/
    Auditorias

core/
    Infraestrutura da aplicação

lib/
    Bibliotecas reutilizáveis

reports/
    Relatórios

logs/
    Logs

state/
    Estado da última auditoria

tmp/
    Arquivos temporários
```

---

# Níveis de risco

Todos os itens encontrados deverão receber uma classificação de risco.

## 🔵 Informativo

Nenhuma ação recomendada.

Exemplos:

- Python atualizado
- uv instalado
- pipx instalado

---

## 🟢 Baixo

Pode ser removido com segurança.

Exemplos:

- cache do pip
- cache do uv
- wheels antigas
- arquivos temporários

---

## 🟡 Médio

Requer análise do usuário.

Exemplos:

- ambientes virtuais antigos
- pacotes instalados com --user
- diretórios órfãos

---

## 🔴 Alto

Nunca remover automaticamente.

Exemplos:

- pacotes globais
- bibliotecas do sistema
- instalações gerenciadas pelo sistema operacional
- diretórios pertencentes ao Python instalado via apt

---

# Processo de limpeza

Toda limpeza deverá seguir duas etapas.

## Planejamento

Construção de um plano contendo:

- itens encontrados
- espaço recuperável
- riscos
- justificativas

Nenhuma alteração será realizada nesta etapa.

---

## Execução

Após confirmação do usuário, o plano será executado.

---

# Dry Run

Todas as operações destrutivas deverão suportar simulação.

Exemplo:

```
python-doctor clean --dry-run
```

Nenhuma alteração será realizada.

---

# Health Score

Cada auditoria contribuirá para uma pontuação geral do ambiente.

Exemplo:

```
Python Health

82 / 100

Risco Geral

Médio
```

A pontuação deverá representar a saúde do ambiente Python e servir apenas como indicador.

Nunca substituirá a análise detalhada.

---

# Princípios de Auditoria

Todos os módulos localizados em `checks/` deverão seguir as regras abaixo.

Estas regras garantem consistência nos resultados, previsibilidade para o usuário e segurança durante a execução das auditorias.

## 1. Nunca assumir

Se uma informação não puder ser determinada com segurança, o resultado deverá indicar explicitamente que ela é desconhecida.

Nunca fazer inferências sem evidências.

Exemplo:

✔ Correto

Projeto associado:
Desconhecido

✖ Incorreto

Projeto associado:
Provavelmente abandonado.

---

## 2. Basear-se em evidências

Toda conclusão deve possuir uma evidência objetiva.

Sempre que possível informar:

- caminho do arquivo
- comando executado
- configuração encontrada
- variável de ambiente utilizada

Exemplo:

Instalação encontrada em:

/usr/local/lib/python3.12/site-packages

---

## 3. Nunca remover por inferência

O Python Doctor nunca deverá remover automaticamente um recurso apenas porque ele parece não estar sendo utilizado.

Exemplos:

- ambientes virtuais
- pacotes globais
- instalações em ~/.local
- bibliotecas compartilhadas

Sempre exigir confirmação do usuário.

---

## 4. Explicar a recomendação

Toda recomendação deverá conter uma justificativa técnica.

Exemplo:

Recomendação:

Mover esta ferramenta para pipx.

Motivo:

Ferramentas CLI devem permanecer isoladas das bibliotecas utilizadas por projetos.

---

## 5. Classificar o risco

Todo resultado deverá possuir um nível de risco.

Categorias:

🔵 Informativo

🟢 Baixo

🟡 Médio

🔴 Alto

---

## 6. Mostrar impacto

Sempre que possível informar:

- espaço ocupado
- espaço recuperável
- aplicações potencialmente afetadas
- diretórios envolvidos

---

## 7. Reprodutibilidade

Um mesmo check executado duas vezes em um ambiente inalterado deve produzir exatamente o mesmo resultado.

Resultados não devem depender de ordem de execução ou efeitos colaterais.

---

## 8. Independência

Cada auditoria deverá funcionar de forma independente.

Nenhum check poderá depender da execução de outro.

O comando `doctor` será responsável por orquestrar as auditorias.

---

## 9. Idempotência

Executar uma auditoria diversas vezes não deve modificar o sistema.

Os módulos em `checks/` nunca devem alterar arquivos, remover diretórios ou modificar configurações.

Eles apenas observam.

---

## 10. Separação entre auditoria e ação

Existe uma separação obrigatória entre:

- identificar
- recomendar
- executar

Os módulos em `checks/` apenas identificam e recomendam.

A execução pertence exclusivamente ao comando `clean`.

---

## 11. Clareza para o usuário

Sempre que possível, utilizar linguagem compreensível.

Evitar jargões quando eles não forem necessários.

Quando termos técnicos forem utilizados, explicar seu significado e impacto.

O objetivo do Python Doctor é auxiliar tanto usuários experientes quanto aqueles que ainda estão aprendendo o ecossistema Python.

---

## 12. Segurança acima da conveniência

Em caso de dúvida, o Python Doctor sempre adotará a opção mais conservadora.

É preferível deixar de remover um recurso potencialmente inútil do que remover um recurso necessário ao funcionamento de aplicações existentes.

---

## 13. Não reinventar o ecossistema Python

O Python Doctor não substitui as ferramentas oficiais do ecossistema Python.

Sua responsabilidade é auditar, diagnosticar, explicar e orientar o usuário na utilização dessas ferramentas, e não reimplementar suas funcionalidades.

Ferramentas como:

- Python
- pip
- pipx
- uv
- Poetry
- pyenv
- venv

continuam sendo responsáveis por instalar, remover, atualizar e gerenciar ambientes e dependências.

O Python Doctor atua como uma camada de diagnóstico e orientação.

### O que o Python Doctor faz

- Identifica problemas de configuração.
- Detecta más práticas.
- Explica o impacto de cada problema.
- Classifica o nível de risco.
- Sugere ações corretivas.
- Indica a ferramenta apropriada para resolver cada situação.

### O que o Python Doctor não faz

- Não instala versões do Python.
- Não gerencia versões do Python.
- Não cria ambientes virtuais.
- Não instala bibliotecas.
- Não substitui o pip, pipx, uv, Poetry ou pyenv.
- Não modifica o ambiente sem autorização explícita do usuário.

### Exemplo

Em vez de criar um ambiente virtual automaticamente, o Python Doctor poderá apresentar uma recomendação como:

```
Foi detectado que este projeto não utiliza um ambiente virtual.

Recomendação:

Crie um ambiente virtual utilizando uma das ferramentas suportadas:

• python -m venv .venv
• uv venv
• Poetry (caso o projeto utilize Poetry)

Benefício:

Cada projeto passa a possuir dependências isoladas, reduzindo conflitos de versões e facilitando a manutenção.
```

Da mesma forma, caso uma ferramenta de linha de comando tenha sido instalada com `pip install`, o Python Doctor poderá sugerir sua migração para o `pipx`, explicando os motivos e apresentando os comandos necessários para realizar essa migração.

O objetivo do Python Doctor é orientar o usuário na adoção das melhores práticas do ecossistema Python, utilizando as ferramentas corretas para cada finalidade, em vez de substituí-las.

---

# Regras de desenvolvimento

- Não duplicar código.
- Evitar dependências externas.
- Priorizar compatibilidade com Bash.
- Todas as funções devem possuir uma única responsabilidade.
- Todo módulo deve ser reutilizável.
- Toda funcionalidade nova deve respeitar este documento.

---

# Missão

Ajudar usuários Linux a manter um ambiente Python limpo, organizado, seguro e alinhado às melhores práticas da comunidade, sem comprometer aplicações existentes.