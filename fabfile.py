from fabric.api import task, run, execute


BREW = '/usr/local/bin/brew '
BREW_CONFIG_DIR = 'brew/'

NPM = '/usr/local/bin/npm '
NPM_CONFIG_DIR = 'npm/'

@task
def install_homebrew():
    run('ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"')
    run(BREW + ' install phinze/cask/brew-cask')


@task
def update_brew():
    run(BREW + 'update')
    run(BREW + 'upgrade')

@task
def install_from_brew():
    execute(tab_brews)
    execute(install_brew_apps)

@task
def tab_brews():
    with open(BREW_CONFIG_DIR + 'taps.txt', 'r') as f:
        taps = f.read().splitlines()
        for tap in taps:
            run(BREW + 'tap ' + tap)

@task
def install_brew_apps():
    with open(BREW_CONFIG_DIR + 'tools.txt', 'r') as f:
        tools = f.read().splitlines()
        for tool in tools:
            run(BREW + 'install ' + tool)

@task
def npm_install_global():
    with open(NPM_CONFIG_DIR + 'global-tools.txt', 'r') as f:
        tools = f.read().splitlines()
        for tool in tools:
            run(NPM + 'install -g --upgrade ' + tool)


def bootstrap():
    execute(install_homebrew)
    execute(update_brew)
    execute(install_brew_apps)
    execute(npm_install_global)
