<?php
header('Content-Type: application/json');

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if ($uri === '/' || $uri === '') {
    echo json_encode([
        'message' => 'Hello from PHP App',
        'version' => '1.0.0'
    ]);
} elseif ($uri === '/health') {
    $hostname = gethostname();
    echo json_encode([
        'status' => 'healthy',
        'hostname' => $hostname
    ]);
} else {
    http_response_code(404);
    echo json_encode(['error' => 'Not found']);
}
?>
