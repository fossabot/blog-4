---
title: "Introdução ao Docker"
description: "Docker e o projeto moby se tornaram nos últimos anos um divisor de águas para a indústria de TI. Veja mais detalhes de como iniciar a usar esta ferramenta que traz diversos benefícios para você e sua equipe."
date: 2018-04-03T12:38:59Z
thumbnail: "images/docker.jpg"
---

Docker e o projeto moby se tornaram nos últimos anos um divisor de águas para a indústria de TI, começou como um projeto proprietário por [Solomon Hykes](https://github.com/shykes) enquanto trabalhava na empresa *dotCloud*, atualmente *Docker Inc.*.

{{% githubcard path="moby/moby" %}}

O docker utiliza por baixo o *LXC*, uma das alternativas de containeres nativas do Linux.

{{% githubcard path="lxc/lxc" %}}

### Mas o que seriam containeres para software ?

Considerando um típico ambiente de desenvolvimento client/servidor, enviar código para produção é uma tarefa mais dificil do que deveria ser. Pense por exemplo na quantidade de ferramentas necessárias para que um desenvolvedor mobile possa realizar suas tarefas do início ao fim.

Além disso, imagine que o código desse desenvolvedor precisa rodar em diferentes plataformas, diferentes hardwares, ambientes heterogêneos que possuem versões diferentes de bibliotecas, binários e tudo mais.

O projeto *docker*, agora chamado *moby*, veio para resolver este e outros problemas com containeres.

### Mas como esses containeres podem lhe ajudar?

{{% img src="images/docker_container.png" w="321" h="264" class="right" %}}

Pense por um instante na forma como containeres funcionam na vida real, na pratica temos um caixa de tamanhos conhecidos mundialmente, qualquer coisa pode ser colocada dentro de um container, e como os tamanhos são padrões, navios e portos podem otimizar maquinários para manipular com eficiência esses containeres.

Também existe a questão da divisão de responsábilidade, a pessoa ou empresa que quiser utilizar um container para transportar algo tem a única responsábilidade de colocar os itens dentro do container. Essa pessoa não precisa saber como esse container chegará ao destino, ficando assim transparente a forma como isso é feito.

De forma equivalente a está abstração do cliente, transportadores não precisam saber o que é transportado nos containeres, possuem apenas a responsábilidade de transportar o container para o destinatário.

Fazendo agora uma análogia com software, criamos um container onde instalamos todas nossas dependências, sejam qual for e uma vez criado o container mandamos este para o servidor de produção, que possue apenas a responsábilidade de rodar o container, seja o que for que estiver rodando neste. Garante-se que se o container roda localmente rodará em produção sem problema nenhum, pois tudo que é necessário para rodar o software está no próprio container, não tendo nenhuma dependência ao servidor onde este container está rodando.

Para demostrar o quanto este conceito pode ser útil vamos ver alguns exemplos abaixo.


##### Hello World

Deixando um pouco a teoria de lado, vamos ver na prática como funciona, a primeira coisa a se fazer para começar a criar seus containeres é instalar o docker, se você usa qualquer distribuição linux suportada é só rodar o comando abaixo:

```sh
# curl -fsSL get.docker.com | sh
```

> Obs: Ao final da instalação será pedido para você adicionar seu usuário ao grupo docker

Caso você use Windows ou Mac por favor acesse o site do [docker](https://docker.com).

Isto irá criar um grupo chamado *docker* na sua máquina e todo usuário deste grupo terá acesso ao daemon do docker e consequentemente a criação a manipulação de containeres.

Para confirmar que está tudo certo vamos rodar nosso primeiro container:

{{% asciinema id="173970" %}}

Executando o comando acima o docker irá buscar pela imagem *hello-world* localmente, se você não a possuir será baixado, o conceito de *imagem* em containeres é bastante simples, um container sempre será uma instância de uma imagem, você pode associar isso a orientação a objetos, onde a imagem do container é sua classe e o container propriamente é um objeto. Existem diversas imagens já disponibilizadas em servidores de imagens conhecidos como *docker registry*, você pode ter o seu próprio ou usar um público como o da própria *Docker Inc.* chamado de [hub](http://hub.docker.com/).


##### Exemplo real

Vamos agora ver um exemplo real, considerando um cenário de desenvolvimento WEB, normalmente temos um servidor de aplicação, que pode rodar por exemplo um *Nginx* como proxy reverso, e um banco de dados, como por exemplo um *MySQL*.

Como podemos ver neste cenário teriamos 2 servidores, como estamos utilizando containeres, teremos 2 containeres rodando, um com Nginx e outro com MySQL, e para iniciarmos esses 2 containeres utilizaremos uma outra ferramenta do docker chamada *docker-compose*, que permite gerênciar serviços, e estes serviços por sua vez podem rodar um ou mais containeres.

Antes de prosseguirmos precisaremos instalar o *docker-compose*, para isto basta rodar o comando abaixo no terminal, se você usa o Linux.

```sh
sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

```

> Obs.: Caso você utilize outra plataforma por favor acesse a [página de instalação](https://docs.docker.com/compose/install/).

Após o término da instalação tente rodar o seguinte comando:

{{% asciinema id="175046" %}}

O comando acima imprimirá o `help` do docker-compose, mostrando todos os comandos possíveis, você pode encontrar mais informações e detalhes de cada comando neste [link](https://docs.docker.com/compose/compose-file/).

Agora que temos o `docker-compose` instalado podemos começar a montar nosso ambiente, primeiro de tudo crie uma nova pasta em um local qualquer e crie um arquivo `index.html` que será nossa página inicial, veja abaixo um exemplo.

```html
<html>
    <head>
        <title>Exemplo</title>
    </head>
    <body>
        <h1>Exemplo de como rodar sua aplicação dentro de um container</h1>
    </body>
</html>
```

Salve e crie um novo arquivo chamado `docker-compose.yml`, será neste arquivo que vamos começar a definir nossos serviços que serão rodados por containeres, além disso coloque o conteúdo mostrado abaixo, ireis explicar o que significa cada linha.

```docker
version: "3.6"

services:
  web:
    image: nginx
    volumes:
      - .:/usr/share/nginx/html
```

> O arquivo `docker-compose.yml` utiliza a sintaxe do `YAML`, uma alternativa menos "verbose" ao `XML`.

Explicando rapidamente a sintaxe, na primeira linha definimos a versão da api do `docker-compose` que iremos utilizar, nesse caso "3.6", todo arquivo `docker-compose.yml` precisa obrigatóriamente possuir esta linha para que o `docker` saíba qual a sintaxe a ser seguida.

Após definirmos a versão, começamos a definir nossos serviços, passamos um `array` de serviços na posição "services". Neste primeiro momento estamos definindo um único serviço chamado "web", este serviço utiliza a imagem do [nginx](https://hub.docker.com/_/nginx) para disponibilizar nossa página estática `index.html`. Por fim, definimos os volumes que serão montados, um volume no contexto de containeres docker são locais de armazenamento de arquivos, que utilizam algum driver para sincronizar este arquivos com algum outro local. Por padrão o docker utiliza o driver `local`, que mantém os arquivos dentro do container sincronizados com algum diretório local da sua máquina. Neste exemplo estamos dizendo para sincronizar o diretório `.` que significa o diretório atual em relação ao arquivo `docker-compose.yml`, ao diretório `/usr/share/nginx/html` do container.

Para iniciar tudo precisamos rodar o comando abaixo:

{{% asciinema id="175047" %}}

Isso iniciará todos os serviços, podemos consultar quais serviços estão rodando com o seguinte comando:

{{% asciinema id="175048" %}}

O comando `docker-compose ps` imprimirá uma tabela mostrando todos os serviços rodando, nesse caso podemos ver que o serviço `web` está com "State" igual a "UP" indicando que o serviço está rodando, além disso podemos ver o comando que o serviço está rodando, no caso "nginx -g daemon off;", por fim podemos ver quais portas o container está exportando, atenção para esta informação, pois o container estar exportando uma porta significa apenas que podemos associar a porta deste container a uma porta qualquer de nosso máquina.

Agora que verificamos que o container está rodando podemos acessar o IP do container para vermos nossa página `index.html` sendo mostrada, para descobrir o IP basta rodar o comando abaixo:

{{% asciinema id="175049" %}}

O comando `docker-compose exec` executa um comando dentro do container, por estarmos usando o `docker-compose` esperá-se ser passado o nome do serviço como parâmetro, no nosso caso o nome é "web" conforme definimos no arquivo `docker-compose.yml`, o comando que está sendo executado é `hostname -i` que básicamente imprime o IP.

> Obs.: O IP do container pode variar dependendo do ambiente

Acessando o IP no navegar conseguimos visualizar nossa página `index.html`

{{% img src="/images/exemplo_nginx_docker_0.png" w="1153" h="37" %}}

Parece que esquemos de colocar o `charset`, adicione o conteúdo abaixo.

```html
<html>
    <head>
        <title>Exemplo</title>
        <meta charset="utf-8">
    </head>
    <body>
        <h1>Exemplo de como rodar sua aplicação dentro de um container</h1>
    </body>
</html>
```

Agora salve e atualize a página.

{{% img src="/images/exemplo_nginx_docker_1.png" w="1153" h="37" %}}

Agora sim :smile: , corrigimos o `charset` e agora os acentos estão sendo mostrados corretamente. Perceba que qualquer alteração do arquivo localmente se reflete dentro do container, isso acontece devido a configuração de `volumes` que fizemos para este container.

### Banco de dados rodando em uma linha

Agora que vimos como rodar um container com `nginx` vejamos como adicionar um instância de um banco de dados `MySQL`. Antes de mais nada gostaria de mencionar um padrão que muitas imagens do docker utilizam, muitas delas utilizam variáveis de ambiente para alterarem seu comportamento, no caso de bancos de dados como  MySQL existem algumas variáveis de ambiente que podemos usar, veja abaixo algumas.

 - MYSQL_ROOT_PASSWORD = senha do usuário root
 - MYSQL_DATABASE = nome do banco de dados a ser criado
 - MYSQL_USER = nome de usuário dono do banco de dados criado
 - MYSQL_PASSWORD = senha do usuário

 Outras variáveis de ambiente podem ser consultadas na [página](https://hub.docker.com/_/mysql) da imagem oficial.

 Essas variáveis nos permitem customizar o comportamento do container MySQL de forma fácil e rápida, veja abaixo como podemos declarar variáveis de ambiente no arquivo `docker-compose.yml`.

 ```docker
version: "3.6"

services:
  web:
    image: nginx
    volumes:
      - .:/usr/share/nginx/html

  database:
    image: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=secret
```

Isso irá declarar dentro dos containeres do serviço `database` as variáveis de ambiente para deixar a senha do usuário `root` como `secret`. Vamos testar criando os containeres que faltando com o comando abaixo:

{{% asciinema id="175066" %}}

O `docker-compose` irá baixar a imagem do MySQL e rodará um novo container, podemos tentar conectar ao banco, para saber o IP utilize o mesmo comando que fizemos anteriormente.

{{% asciinema id="175067" %}}

{{% contribute %}}
