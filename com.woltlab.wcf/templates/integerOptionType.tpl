<input type="number" id="{$option->optionName}" name="values[{$option->optionName}]" value="{$value}"{if $option->minvalue !== null} min="{$option->minvalue}"{/if}{if $option->maxvalue !== null} max="{$option->maxvalue}"{/if}{if $inputClass} class="{@$inputClass}"{/if}{if $option->required} required{/if}>