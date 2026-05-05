param(
  [int]$Port = 8080,
  [string]$Root = (Split-Path -Parent $MyInvocation.MyCommand.Path)
)

$ErrorActionPreference = "Stop"

$mime = @{
  ".html" = "text/html; charset=utf-8"
  ".htm"  = "text/html; charset=utf-8"
  ".css"  = "text/css; charset=utf-8"
  ".js"   = "application/javascript; charset=utf-8"
  ".json" = "application/json; charset=utf-8"
  ".svg"  = "image/svg+xml"
  ".png"  = "image/png"
  ".jpg"  = "image/jpeg"
  ".jpeg" = "image/jpeg"
  ".gif"  = "image/gif"
  ".ico"  = "image/x-icon"
  ".woff" = "font/woff"
  ".woff2"= "font/woff2"
}

$listener = New-Object System.Net.HttpListener
$prefix = "http://localhost:$Port/"
$listener.Prefixes.Add($prefix)

try { $listener.Start() } catch {
  Write-Host "ERROR: could not start listener on $prefix - $_"
  exit 1
}

Write-Host "Serving $Root"
Write-Host "Listening on $prefix"
Write-Host "Press Ctrl+C to stop"

while ($listener.IsListening) {
  try {
    $ctx = $listener.GetContext()
  } catch { break }

  $req = $ctx.Request
  $res = $ctx.Response

  $relative = $req.Url.AbsolutePath.TrimStart("/")
  if ([string]::IsNullOrEmpty($relative)) { $relative = "index.html" }

  $path = Join-Path $Root $relative

  if (Test-Path $path -PathType Leaf) {
    $ext = [System.IO.Path]::GetExtension($path).ToLower()
    $type = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { "application/octet-stream" }
    $bytes = [System.IO.File]::ReadAllBytes($path)
    $res.StatusCode = 200
    $res.ContentType = $type
    $res.ContentLength64 = $bytes.Length
    $res.OutputStream.Write($bytes, 0, $bytes.Length)
    Write-Host "$($req.HttpMethod) $relative -> 200"
  } else {
    $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $relative")
    $res.StatusCode = 404
    $res.ContentType = "text/plain; charset=utf-8"
    $res.ContentLength64 = $msg.Length
    $res.OutputStream.Write($msg, 0, $msg.Length)
    Write-Host "$($req.HttpMethod) $relative -> 404"
  }

  $res.Close()
}

$listener.Stop()
