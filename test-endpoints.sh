#!/bin/bash

CURL_CODE='curl -s -o /dev/null -I -w "%{http_code}"'
CURL_URL='curl -Ls -o /dev/null -w %{url_effective}'

FAIL=false

function test_endpoint()
{
    expected_code=$1
    shift

    result_code=$(eval $CURL_CODE $@)

    result_url=$(eval $CURL_URL $@)
    result_url=${result_url%/}

    if [[ "$result_code" != "$expected_code" ]] | [[ "$result_url" != "https://onesignal.daleysoftware.com" ]]
    then
        echo "Failed at $@, got code $result_code and URL $result_url"
        FAIL=true
    fi
}

test_endpoint 301 http://onesignal.daleysoftware.com
test_endpoint 200 https://onesignal.daleysoftware.com

if [[ $FAIL == "true" ]]
then
    exit 1
else
    echo "Endpoints are functioning as intended."
fi
