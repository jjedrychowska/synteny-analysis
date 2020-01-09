SELECT
    IFNULL(xref.display_label, stable_id) as name,
    REPLACE(seq_region.name, 'LG', '') -- needed for lepisosteus_oculatus_core_98_1
        as chromosome,
    gene_attrib.value,
    gene.description, seq_region_start, seq_region_end, seq_region_strand, biotype, stable_id
FROM gene
    LEFT JOIN gene_attrib ON
        gene_attrib.gene_id = gene.gene_id AND gene_attrib.attrib_type_id = 4 -- name
    LEFT JOIN xref ON
        gene.display_xref_id = xref.xref_id
    LEFT JOIN seq_region ON
        gene.seq_region_id = seq_region.seq_region_id
WHERE
REPLACE(seq_region.name, 'LG', '') REGEXP '^[[:digit:]]+$' AND
biotype = 'protein_coding'

ORDER BY convert(seq_region.name, SIGNED INTEGER), seq_region.name, seq_region_start
