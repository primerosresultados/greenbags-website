-- ============================================================
-- CLIENTE: GreenBags - limpieza de "Sobre GreenBags" (PDF jun 2026, punto 12)
-- ============================================================
-- Ajustes de copy sobre /sobre-greenbags:
--   - ELIMINAR la fila de stats duplicada (15+ / 24-48h / 100% / B2B): ya
--     aparece como badge en el hero; abajo se repetia.
--   - Quitar voseo (trabajas/Hablas/Contanos/necesitas) -> Chile.
--   - Sacar la bajada "desde el food truck del barrio".
-- REPLACE no-op si ya se edito desde admin -> idempotente.
-- Al forkear, borrar este archivo (ver docs/FORK_NEW_CLIENT.md).
-- ============================================================

UPDATE pages SET body = REPLACE(body,
'    <!-- =========== STATS =========== -->
    <div class="gb-about__stats">
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7 V12 L15 14"/></svg></span>
            <div class="gb-about__stat-num"><em>15+</em></div>
            <div class="gb-about__stat-label">Años de experiencia en el rubro</div>
        </div>
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 7 H17 L21 11 V17 H3 Z"/><circle cx="7" cy="18" r="2"/><circle cx="17" cy="18" r="2"/></svg></span>
            <div class="gb-about__stat-num">24-48<em>h</em></div>
            <div class="gb-about__stat-label">Despachos en Región Metropolitana</div>
        </div>
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M3 12 H21 M12 3 a14 14 0 0 1 0 18 M12 3 a14 14 0 0 0 0 18"/></svg></span>
            <div class="gb-about__stat-num">100<em>%</em></div>
            <div class="gb-about__stat-label">Cobertura nacional en Chile</div>
        </div>
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21 V8 Q3 4 8 4 H16 Q21 4 21 8 V21 Z"/><path d="M8 11 H16 M8 15 H13"/></svg></span>
            <div class="gb-about__stat-num">B2B</div>
            <div class="gb-about__stat-label">Atención directa de los dueños</div>
        </div>
    </div>

',
'')
 WHERE slug = 'sobre-greenbags';

UPDATE pages SET body = REPLACE(body, 'Sin intermediarios: trabajás directamente con quienes toman las decisiones.', 'Sin intermediarios: trabajas directamente con quienes toman las decisiones.') WHERE slug = 'sobre-greenbags';
UPDATE pages SET body = REPLACE(body, 'Sin call centers ni capas intermedias. Hablás con quienes deciden y resuelven, todos los días.', 'Sin call centers ni capas intermedias. Hablas con quienes deciden y resuelven, todos los días.') WHERE slug = 'sobre-greenbags';
UPDATE pages SET body = REPLACE(body, 'Contanos qué productos necesitás y tu equipo de GreenBags te enviará una propuesta a medida en 24-48 horas hábiles.', 'Cuéntanos qué productos necesitas y el equipo de GreenBags te enviará una propuesta a medida en 24-48 horas hábiles.') WHERE slug = 'sobre-greenbags';
UPDATE pages SET body = REPLACE(body, 'desde el food truck del barrio hasta cadenas con presencia nacional.', 'desde emprendedores gastronómicos hasta cadenas con presencia nacional.') WHERE slug = 'sobre-greenbags';
