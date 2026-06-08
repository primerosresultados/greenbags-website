-- ============================================================
-- SEED: páginas /favoritos y /mi-cuenta
-- ============================================================
-- El header ahora muestra dos íconos (favoritos + mi cuenta) a la izquierda
-- del carrito. Apuntan a estas dos páginas. Ambas se siembran:
--   - publicadas → /favoritos y /mi-cuenta funcionan tras el deploy.
--   - excluidas del menú → no aparecen como links de texto en el nav
--     (se accede solo desde los íconos del header y el drawer mobile).
--
-- El body es placeholder editable desde admin → Páginas. Cuando el cliente
-- decida implementar el flujo real, simplemente reemplaza el HTML desde
-- el panel sin tocar código.
--
-- Idempotente: usa INSERT IGNORE; si la página ya existe (slug es UNIQUE)
-- no se toca el contenido editado por el cliente.
-- ============================================================

INSERT IGNORE INTO pages (slug, title, body, meta_description, is_published, exclude_from_menu) VALUES
    ('favoritos',
     'Mis favoritos',
     '<div style="text-align:center;padding:2rem 0 1rem;">
  <svg viewBox="0 0 24 24" width="56" height="56" fill="none" stroke="#73BF6D" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom:1rem;"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
  <p style="font-size:1.05rem;color:#475569;max-width:520px;margin:0 auto 1.5rem;line-height:1.55;">
    Próximamente vas a poder guardar tus productos favoritos para revisarlos cuando quieras.
    Mientras tanto, explorá nuestro catálogo y armá tu cotización.
  </p>
  <p style="margin:0;">
    <a href="/tienda" class="btn">Ir a la tienda</a>
    <a href="/cotizacion" class="btn btn--secondary" style="margin-left:.5rem;">Ver mi cotización</a>
  </p>
</div>',
     'Tus productos favoritos en GreenBags — guardá lo que más te interesa para revisar después.',
     1, 1),

    ('mi-cuenta',
     'Mi cuenta',
     '<div style="text-align:center;padding:2rem 0 1rem;">
  <svg viewBox="0 0 24 24" width="56" height="56" fill="none" stroke="#73BF6D" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom:1rem;"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
  <p style="font-size:1.05rem;color:#475569;max-width:560px;margin:0 auto 1.5rem;line-height:1.55;">
    Próximamente vas a poder ingresar para ver el estado de tus cotizaciones,
    tu historial de pedidos y tus datos de facturación.
  </p>
  <p style="margin:0 0 2rem;">
    <a href="/cotizacion" class="btn">Pedir una cotización</a>
    <a href="/contacto" class="btn btn--secondary" style="margin-left:.5rem;">Contactar a un ejecutivo</a>
  </p>
  <div style="border-top:1px solid #e5e7eb;padding-top:1.5rem;margin-top:1rem;max-width:480px;margin-left:auto;margin-right:auto;">
    <h3 style="margin:0 0 .5rem;font-size:1rem;color:#0f172a;">¿Ya tenés una cotización en curso?</h3>
    <p style="color:#64748b;font-size:.95rem;margin:0;line-height:1.55;">
      Escribinos a <a href="mailto:contacto@greenbags.cl">contacto@greenbags.cl</a> con tu número de cotización y un ejecutivo te pone al día en menos de 24 horas.
    </p>
  </div>
</div>',
     'Tu cuenta de GreenBags — accedé a tus cotizaciones, pedidos y datos.',
     1, 1);
