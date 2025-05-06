    def main [...args] {
    	with-env {
    		SHELL:_SHELL_,
    		acmeshell:_SHELL_,
    		BROWSER:_BROWSER_,
    		tabstop:2,
    		TERM:dumb,
    		PAGER:nobs
    	} {
    		let _args = if ($args | is-empty) {"."} else {$args | str join ' '}
    		9 acme -a -f /mnt/font/_FONT_/_SIZE_/font $_args
    	}
    }