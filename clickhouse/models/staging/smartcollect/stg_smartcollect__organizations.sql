--- organizations

with organizations as (
    select
        id as organization_id,
        ref_id as organization_ref_id,
        names as organization_names,
        tagline as organization_tagline,
        agency_id as agency_id,
        is_primary as organization_is_primary,
        organization_type_id,
        address as organization_address,
        phone as organization_phone,
        email as organization_email,
        website as organization_website,
        letter_head_path as organization_letter_head_path,
        footer_path as organization_footer_path,
        country_id as country_id,
        currency_id as currency_id,
        multi_currency_enabled as organization_multi_currency_enabled,
        countries_enabled as organization_countries_enabled,
        branches_enabled as organization_branches_enabled,
        teams_enabled as organization_teams_enabled,
        extra_attributes as organization_extra_attributes,
        last_edited_time as organization_last_edited_time,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        updated_at::timestamp as updated_at

    from
        {{ source('smartcollect', 'organizations') }}
    where
        deleted_at is null and active = 1
)

select * from organizations