.value
| (. / "") as $chars
| [ $chars[ range(length; 0; -1) - 1 ] ]
| add + ""
