---
title: "Introdução ao Docker"
date: 2018-04-02T12:38:59Z
---

Docker e o projeto [moby](https://github.com/moby/moby) se tornaram nos últimos anos um divisor de águas para a indústria de TI. Iniciado como um projeto proprietário por [Solomon Hykes](https://github.com/shykes) enquanto trabalha na empresa *dotCloud*, logo virou o carro chefe da empresa que inclusive mudou seu nome para *Docker Inc.* devido ao tamanho do sucesso do docker.

#### Mas o que é o *docker* ?

O docker é uma ferramenta de conteinerização de software, em outras palavras, uma interface amigável para que os usuários possam criar caixas pretas, ou ambientes controlados e seguros para rodar seus softwares. Na prática, o docker resolve um dos maiores problemas do desenvolvimento de software, a entrega e publicação.

Considerando um ciclo normal de desenvolvimento de uma solução, seja ela um projeto inteiro ou somente parte dele, existem diversos momentos que precisamos publicar para que o cliente ou usuário tenha acesso, esse é um momento chave, crítico e que geralmente é o maior ponto de geração de erros e dores de cabeça. Neste momento podem acontecer diferenças entre os ambientes de desenvolvimento e produção, falhas podem passar desapercebidas, falta de testes automatizados podem deixar pontas soltas, o que no final acaba gerando pressões sobre a equipe, o cliente impactado e a imagem da empresa pode ser manchada, tudo de errado pode acontecer nesse processo crucial para o sucesso e satisfação de todos.

A solução de conteineres resolve isso de forma brilhante, a idéia é criar um *container* ou um ambiente totalmente isolado a nível de sistema operacional onde você monta o ambiente atrelando tudo que precisa de dependências ao mesmo, esse mesmo ambiente é usado durante a etapa de desenvolvimento e por fim exporta-se e implanta-se esse mesmo container criado em produção.

A vantagem de utilizar essa abordagem é justamente o benefício de usar o mesmo ambiente local, de testes e produção, acabando com a velha frase *"na minha máquina funciona"*, já que se funciona na sua máquina irá funcionar em produção.

#### Hello World

Deixando um pouco a teoria de lado, vamo ver na prática como funciona, a primeira coisa a se fazer para começar a criar seus containeres é instalar o docker, se você usa qualquer distribuição linux suportada é só rodar o comando abaixo:

```sh
# curl -fsSL get.docker.com | sh
```

> Obs: Ao final da instalação será pedido para você adicionar seu usuário ao grupo docker

Isto irá criar um grupo chamado *docker* na sua máquina e todo usuário deste grupo terá acesso ao daemon do docker e consequentemente a criação a manipulação de containeres.

Para confirmar que está tudo certo vamos rodar nosso primeiro container:

<script src="https://asciinema.org/a/173970.js" id="asciicast-173970" async></script>

Executando o comando acima o docker irá buscar pela imagem *hello-world* localmente, se você não a possuir será baixado, o conceito de *imagem* em containeres é bastante simples, um container sempre será uma instância de uma imagem, você pode associar isso a orientação a objetos, onde a imagem do container é sua classe e o container propriamente é um objeto. Existem diversas imagens já disponibilizadas em servidores de imagens conhecidos como *docker registry*, você pode ter o seu próprio ou usar um público como o da própria *Docker Inc.* chamado de [hub](http://hub.docker.com/).

To be continue...
