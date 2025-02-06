# 📱 Aplicativo de Cartões

Este aplicativo exibe uma lista de cartões do cliente, permitindo visualizar transações e informações relevantes de cada cartão. Ele foi desenvolvido em **Flutter**, utilizando **MVVM** como padrão arquitetural e **Atomic Design** para organização dos componentes da UI.

## 📸 Capturas de Tela

<p align="center">
  <img src="assets/media/mobile.png" width="45%" />
  <img src="assets/media/mobile.gif" width="45%" />
</p>

---

## 🚀 Tecnologias Utilizadas

- **Linguagem:** Dart
- **Framework:** Flutter
- **Arquitetura:** MVVM
- **Padrão de UI:** Atomic Design (atoms, molecules, organisms, templates)
- **Gerenciamento de estado:** Provider

## 📂 Estrutura do Projeto

O projeto segue uma estrutura modularizada:

```
/lib
 ├── app
 │   ├── models              # Modelos de dados
 │   ├── services            # Serviços e requisições HTTP
 │   ├── viewmodels          # ViewModels (lógica de negócios e estado)
 │   ├── views               # Telas do aplicativo
 │   │   ├── widgets         # Componentes reutilizáveis
 │   │   │   ├── atoms       # Elementos básicos (ex: botões, textos)
 │   │   │   ├── molecules   # Pequenos agrupamentos de átomos
 │   │   │   ├── organisms   # Componentes mais complexos
 │   │   │   ├── templates   # Estruturas completas de tela
 │   │   ├── home_view.dart  # Tela principal
 ├── core
 │   ├── shared              # Componentes compartilhados (AppBar, Drawer, etc.)
 │   ├── utils               # Utilitários e funções auxiliares
 │   ├── constants           # Constantes globais do app
```

## 🛠 Dependências Externas

As seguintes bibliotecas foram utilizadas no projeto:

```yaml
dependencies:
  equatable: ^2.0.7
  http: ^1.3.0
  provider: ^6.1.2
  flutter_svg: ^2.0.17
  intl: ^0.20.2

dev_dependencies:
  mockito: ^5.4.5
```

## 📌 Instruções para Execução

### Pré-requisitos

Certifique-se de ter instalado:

- **Flutter** (https://flutter.dev/docs/get-started/install)
- **Dart**
- **Emulador ou dispositivo físico**

### Como rodar o projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/origemjhanpoll/flutter_gs3_test
   cd flutter_gs3_test
   ```

2. Instale as dependências:

   ```bash
   flutter pub get
   ```

3. Execute o aplicativo:
   ```bash
   flutter run
   ```

_(Para rodar no iOS, é necessário um Mac com Xcode instalado.)_

## ❌ Suporte para Web

Atualmente, este aplicativo **não possui suporte para Web**. Ele foi desenvolvido exclusivamente para **Android e iOS**.

## 🤝 Contribuição

Sinta-se à vontade para abrir issues ou contribuir com melhorias!

## 📄 Licença

Este projeto está sob a licença MIT.
