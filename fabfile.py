from fabric.api import task, run, execute


BREW = '/usr/local/bin/brew '
BREW_CONFIG_DIR = 'brew/'

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
            run(BREW + 'install ' + tap)


def bootstrap():
    execute(install_homebrew)
    execute(update_brew)
    execute(install_brew_apps)
