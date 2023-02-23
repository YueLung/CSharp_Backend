using System;
using System.ComponentModel.DataAnnotations;
using Core.Extensions;

namespace Core.Attributes
{
    public class ValidEnumNameAttribute : ValidationAttribute
    {
        private readonly Type _enumType;

        public ValidEnumNameAttribute(Type enumType)
        {
            _enumType = enumType;

            if (!_enumType.IsEnum)
                throw new ArgumentException($"ValidEnumNameAttribute {nameof(enumType)} must be Enum");
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value == null) return ValidationResult.Success;

            foreach (string name in Enum.GetNames(_enumType))
            {
                if (name == value.ToString()) return ValidationResult.Success;
            }

            foreach (Enum item in Enum.GetValues(_enumType))
            {
                if (item.GetEnumMember() == value.ToString()) return ValidationResult.Success;
            }

            return new ValidationResult($"{ value } is not valid enum name for type { _enumType.Name }");
        }
    }
}
