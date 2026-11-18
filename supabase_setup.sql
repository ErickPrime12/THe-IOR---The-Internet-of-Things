-- Ejecuta esto UNA vez en Supabase: SQL Editor -> New query -> Run
create table if not exists public.ior_docs (
  col text not null,
  id  text not null,
  j   text not null,
  u   bigint not null default 0,
  primary key (col, id)
);
alter table public.ior_docs enable row level security;
drop policy if exists "ior_docs_all" on public.ior_docs;
create policy "ior_docs_all" on public.ior_docs for all to anon using (true) with check (true);

-- Almacenamiento público para portadas, fondos, ROMs y medios pequeños
insert into storage.buckets (id, name, public) values ('ior', 'ior', true) on conflict (id) do nothing;
drop policy if exists "ior_obj_read" on storage.objects;
drop policy if exists "ior_obj_insert" on storage.objects;
drop policy if exists "ior_obj_update" on storage.objects;
drop policy if exists "ior_obj_delete" on storage.objects;
create policy "ior_obj_read"   on storage.objects for select to anon using (bucket_id = 'ior');
create policy "ior_obj_insert" on storage.objects for insert to anon with check (bucket_id = 'ior');
create policy "ior_obj_update" on storage.objects for update to anon using (bucket_id = 'ior');
create policy "ior_obj_delete" on storage.objects for delete to anon using (bucket_id = 'ior');
