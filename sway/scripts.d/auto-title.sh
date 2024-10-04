#!/bin/sh
# are your workspace names completely unmanageable?
# don't worry, i gotchu
#
# running this script while continuously update the name of the current
# workspace to the name of the active window
set -xe

crop_text() {
	len="${1}"
	printf %s "$2" | sed "s/^\(.\{,${len}\}\).*\$/  \1/g" | tr -d ':'
}

wl_check_workspace_exists() {
	name="${1}"
	shift
}

wl_guarantee_unique_ws_name() {
	name="$(cat | xargs)"
	pid="${1}"
	if test "$(swaymsg -t get_workspaces |
		jq 'map(select(.name | test("^[[:space:]]*'"${name}"'[[:space:]]*$"))) | length')" -gt 0; then
		printf '[%s] %s' "${pid}" "${name}"
	else
		printf %s "${name}"
	fi

}

wl_prettify_ws_title() {
	app_id="$(printf %s "${1}" | xargs)"
	title="$(printf %s "${2}" | xargs)"
	pid="$(printf %s "${3}" | xargs)"
	shift 3

	if test -n "${app_id}" && test "${app_id}" != null; then
		case "${app_id}" in
			Element) printf '󰘨  %s' "$(crop_text 24 "${title##Element*| }")" ;;
			firefox-esr) printf '󰈹  %s' "$(crop_text 24 "$(printf %s "${title%%'— Mozilla Firefox'}" | sed 's/^\(.*\) at DuckDuckGo[[:space:]]*$/search → \1/')")" ;;
			kitty) printf '  %s' "$(crop_text 24 "${title}")" ;;
			org.pipewire.Helvum) printf '🔉 Helvum' ;;
			org.telegram) printf 'Telegram' ;;
			*) printf 'app_id=¿%s?' "$(crop_text 24 "${app_id}")"
		esac
	elif test -n "${title}"; then
		case "${title}" in
			*"- Discord") printf '󰙯  %s' "$(crop_text 24 "${title##'- Discord'}")" ;;
			*) printf '%s' "$(crop_text 24 "${title}")"
		esac
	else
		printf '%s' "$(crop_text 24 "${title}")"
	fi
}

wl_callback_focused() {
	event="$(cat)"
	name="$(printf '%s' "${event}" | jq -r '.name')"
	app_id="$(printf '%s' "${event}" | jq -r '.app_id')"
	pid="$(printf '%s' "${event}" | jq -r '.pid')"

	# workspace="$(swaymsg -t get_workspaces | jq -r '.[]|select(.focused).name')"
	
	swaymsg rename workspace to "$(wl_prettify_ws_title "${app_id}" "${name}" "${pid}" | wl_guarantee_unique_ws_name "${pid}")"
}

wl_callback_window_event() {
	while read -r window_event; do
		printf %s "${window_event}" |
			jq 'select(.change == "focus" or .change == "title").container |
			{name: .name, app_id: .app_id, id: .id, pid: .pid}' | wl_callback_focused
	done
}

swaymsg --monitor --type subscribe '[ "window" ]' | wl_callback_window_event

