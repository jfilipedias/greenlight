package data

import "github.com/jfilipedias/greenlight/internal/validator"

type Filter struct {
	Page         int
	PageSize     int
	Sort         string
	SortSafeList []string
}

func ValidateFilters(v *validator.Validator, f Filter) {
	v.Check(f.Page > 0, "page", "must be greater than zero")
	v.Check(f.Page <= 10_000_000, "page", "must be a maximum of 10 million")
	v.Check(f.PageSize > 0, "page_size", "must be greater than zero")
	v.Check(f.PageSize <= 100, "page_size", "mus be a maximum of 100")
	v.Check(validator.PermittedValues(f.Sort, f.SortSafeList...), "sort", "invalid sort value")
}
