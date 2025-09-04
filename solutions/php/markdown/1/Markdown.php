<?php
declare(strict_types=1);

// Dedicated to Shree DR.MDD

function parseMarkdown($markdown)
{
    $linesArray = explode("\n", $markdown);

    $insideList = false;

    foreach ($linesArray as &$lineContent) {
        if (preg_match('/^######(.*)/', $lineContent, $matches)) {
            $lineContent = "<h6>" . trim($matches[1]) . "</h6>";
        } elseif (preg_match('/^##(.*)/', $lineContent, $matches)) {
            $lineContent = "<h2>" . trim($matches[1]) . "</h2>";
        } elseif (preg_match('/^#(.*)/', $lineContent, $matches)) {
            $lineContent = "<h1>" . trim($matches[1]) . "</h1>";
        }

        if (preg_match('/\*(.*)/', $lineContent, $matches)) {
            if (!$insideList) {
                $insideList = true;
                $boldFlag = false;
                $italicFlag = false;
                if (preg_match('/(.*)__(.*)__(.*)/', $matches[1], $m2)) {
                    $matches[1] = $m2[1] . '<em>' . $m2[2] . '</em>' . $m2[3];
                    $boldFlag = true;
                }

                if (preg_match('/(.*)_(.*)_(.*)/', $matches[1], $m3)) {
                    $matches[1] = $m3[1] . '<i>' . $m3[2] . '</i>' . $m3[3];
                    $italicFlag = true;
                }

                if ($italicFlag || $boldFlag) {
                    $lineContent = "<ul><li>" . trim($matches[1]) . "</li>";
                } else {
                    $lineContent = "<ul><li><p>" . trim($matches[1]) . "</p></li>";
                }
            } else {
                $boldFlag = false;
                $italicFlag = false;
                if (preg_match('/(.*)__(.*)__(.*)/', $matches[1], $m2)) {
                    $matches[1] = $m2[1] . '<em>' . $m2[2] . '</em>' . $m2[3];
                    $boldFlag = true;
                }

                if (preg_match('/(.*)_(.*)_(.*)/', $matches[1], $m3)) {
                    $matches[1] = $m3[1] . '<i>' . $m3[2] . '</i>' . $m3[3];
                    $italicFlag = true;
                }

                if ($italicFlag || $boldFlag) {
                    $lineContent = "<li>" . trim($matches[1]) . "</li>";
                } else {
                    $lineContent = "<li><p>" . trim($matches[1]) . "</p></li>";
                }
            }
        } else {
            if ($insideList) {
                $lineContent = "</ul>" . $lineContent;
                $insideList = false;
            }
        }

        if (!preg_match('/<h|<ul|<p|<li/', $lineContent)) {
            $lineContent = "<p>$lineContent</p>";
        }

        if (preg_match('/(.*)__(.*)__(.*)/', $lineContent, $matches)) {
            $lineContent = $matches[1] . '<em>' . $matches[2] . '</em>' . $matches[3];
        }

        if (preg_match('/(.*)_(.*)_(.*)/', $lineContent, $matches)) {
            $lineContent = $matches[1] . '<i>' . $matches[2] . '</i>' . $matches[3];
        }
    }

    $htmlContent = join($linesArray);
    if ($insideList) {
        $htmlContent .= '</ul>';
    }
    return $htmlContent;
}
