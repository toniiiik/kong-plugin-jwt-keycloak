local function validate_issuer(allowed_issuers, jwt_claims)
    if allowed_issuers == nil or table.getn(allowed_issuers) == 0 then
        return nil, "Allowed issuers is empty"
    end
    if jwt_claims.iss == nil then
        return nil, "Missing issuer claim"
    end

    -- if exactly one issuer it can be regular expression
    if table.getn(allowed_issuers) == 1 do
        local issuer = allowed_issuers[1]
        if jwt_claims.iss.match(issuer) == jwt_claims.iss then
            return true
        end
        return nil, "Token issuer not allowed"
    end

    for _, curr_iss in pairs(allowed_issuers) do
        if curr_iss == jwt_claims.iss then
            return true
        end
    end
    return nil, "Token issuer not allowed"
end

return {
    validate_issuer = validate_issuer
}