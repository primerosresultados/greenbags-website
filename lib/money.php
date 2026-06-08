<?php
/**
 * Formato y redondeo de moneda para la tienda.
 * Lee la configuración desde settings (store_currency, currency_symbol,
 * currency_decimals). Por defecto: CLP, símbolo $, 0 decimales.
 *
 * En Chile el peso no usa decimales: los montos se redondean a entero antes
 * de enviarse a las pasarelas (Transbank/Flow/MercadoPago) y de mostrarse.
 */

function shopCurrency(): array {
    static $c = null;
    if ($c === null) {
        $c = [
            'code'     => (string) getSetting('store_currency', 'CLP'),
            'symbol'   => (string) getSetting('currency_symbol', '$'),
            'decimals' => (int)    getSetting('currency_decimals', '0'),
        ];
    }
    return $c;
}

/** Redondea según los decimales de la moneda (CLP → entero). */
function shopRound($amount): float {
    $c = shopCurrency();
    return round((float) $amount, $c['decimals']);
}

/** Monto entero para enviar a las pasarelas (CLP no admite decimales). */
function shopAmountForGateway($amount): int {
    return (int) round((float) $amount);
}

/** Formatea un monto para mostrar: "$19.990". */
function shopFormatPrice($amount): string {
    $c = shopCurrency();
    $n = number_format((float) $amount, $c['decimals'], ',', '.');
    return $c['symbol'] . $n;
}
