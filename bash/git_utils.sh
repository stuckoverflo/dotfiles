function set_git_email() {
    remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
    email=florobarotjr@gmail.com # default

    if [[ $remote == *github.com:thinkingmachines* ]]; then
        echo "here"
        email=flo@thinkingmachin.es
    fi

    echo "Configuring user.email as $email"
    git config user.email $email
}
alias sge="set_git_email"
