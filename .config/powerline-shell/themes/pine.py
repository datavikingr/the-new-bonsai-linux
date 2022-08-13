from powerline_shell.themes.default import DefaultColor


class Color(DefaultColor):
    """Pine theme"""
    USERNAME_FG = 7
    USERNAME_BG = 23
    USERNAME_ROOT_BG = 1

    HOSTNAME_FG = 7
    HOSTNAME_BG = 22

    HOME_SPECIAL_DISPLAY = False
    PATH_BG = 28
    PATH_FG = 7  
    CWD_FG = 15  
    SEPARATOR_FG = 7

    READONLY_BG = 1
    READONLY_FG = 7

    REPO_CLEAN_BG = 2   
    REPO_CLEAN_FG = 15   
    REPO_DIRTY_BG = 1   
    REPO_DIRTY_FG = 7  

    JOBS_FG = 7
    JOBS_BG = 2

    CMD_PASSED_BG = 29
    CMD_PASSED_FG = 7
    CMD_FAILED_BG = 9
    CMD_FAILED_FG = 0

    SVN_CHANGES_BG = REPO_DIRTY_BG
    SVN_CHANGES_FG = REPO_DIRTY_FG

#    VIRTUAL_ENV_BG = 2
#    VIRTUAL_ENV_FG = 0

#    AWS_PROFILE_FG = 14
#    AWS_PROFILE_BG = 8

    TIME_FG = 7
    TIME_BG = 24
