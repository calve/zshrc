# Set or unset proxy for university
function proxy_lille1() {
    if [ -n "$http_proxy" ]; then
	unset http_proxy;
	unset https_proxy;
	unset HTTP_PROXY;
	unset HTTPS_PROXY;
    else
	proxy = "cache-etu.univ-lille1.fr:3128";
	export http_proxy = $proxy;
	export https_proxy= $proxy;
	export HTTP_PROXY = $proxy;
	export HTTPS_PROXY= $proxy;
    fi 
}

# Prompt if proxy is set
function rp_proxy () {
    if [ -n "$http_proxy" ]; then
	echo "$FG[$ZSH_THEME_PROXY_BG]$FG[$ZSH_THEME_PROXY_FG]$BG[$ZSH_THEME_PROXY_BG]$http_proxy"
    fi 
}
