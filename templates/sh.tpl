#!/usr/bin/env bash

# ==============================================================================
# Script Name: {{_file_name_}}
# Description: Brief description of what this script does.
# Usage:       ./{{_file_name_}} [options] <required_arg>
# ==============================================================================

# Exit immediately on error (-e), unset variable (-u), or pipe failure (-o pipefail)
# Inherit ERR traps in functions and subshells (-E)
set -Eeuo pipefail

# Resolve the directory where this script is located
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# Default configuration variables
VERBOSE=0
OUTPUT_FILE=""

# Clean up temporary files or processes on exit
cleanup() {
    trap - SIGINT SIGTERM ERR EXIT
    # Add cleanup logic here (e.g., rm -f "$TMP_FILE")
}
trap cleanup SIGINT SIGTERM ERR EXIT

usage() {
    cat <<EOF
Usage: ${SCRIPT_NAME} [-h] [-v] [-o output_file] <input_arg>

Description of what the script accomplishes.

Options:
  -h, --help      Display this help message and exit
  -v, --verbose   Enable verbose output
  -o, --output    Specify an output file path
EOF
    exit 0
}

# Logging helpers (directed to stderr so stdout remains clean for data)
msg() {
    echo >&2 -e "${1-}"
}

die() {
    local msg=$1
    local code=${2-1} # Default exit status 1
    msg "[ERROR] ${msg}"
    exit "${code}"
}

# Parse command-line flags and positional arguments
parse_params() {
    while :; do
        case "${1-}" in
            -h | --help) usage ;;
            -v | --verbose) VERBOSE=1 ;;
            -o | --output)
                OUTPUT_FILE="${2-}"
                [[ -z "${OUTPUT_FILE}" ]] && die "Missing argument for --output"
                shift
                ;;
            -?*) die "Unknown option: $1" ;;
            *) break ;;
        esac
        shift
    done

    ARGS=("$@")

    # Validate required positional arguments
    [[ ${#ARGS[@]} -eq 0 ]] && die "Missing required positional argument. Use -h for help."
    return 0
}

# Main script logic
main() {
    parse_params "$@"

    local input_arg="${ARGS[0]}"

    if [[ "${VERBOSE}" -eq 1 ]]; then
        msg "[INFO] Running ${SCRIPT_NAME} from ${SCRIPT_DIR}"
        msg "[INFO] Processing input: ${input_arg}"
    fi

    # --- Your custom commands go here ---
    echo "Processing ${input_arg}..."
    
    if [[ -n "${OUTPUT_FILE}" ]]; then
        echo "Result for ${input_arg}" > "${OUTPUT_FILE}"
        msg "[INFO] Saved output to ${OUTPUT_FILE}"
    fi
}

main "$@"
