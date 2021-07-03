module SalesHelper
  def success_msg(amount_created)
    {
      title: 'Sucesso!',
      description: "Venda com #{amount_created} pedidos cadastrada!"
    }
  end

  def error_msg(hash_error)
    {
      title: hash_error[:type],
      info: "Linha #{(hash_error[:line] || 0) + 1}, Coluna #{(hash_error[:column] || 0) + 1}",
      description: <<-TEXT
                  Esperava: #{hash_error[:expected]}.
                  Recebeu: #{hash_error[:value]}
      TEXT
    }
  end

  def readable?(file)
    file_type, status = Open3.capture2e('file', file.path)
    status.success? && file_type.include?('text')
  end

  def report_file
    sales_params.open
  end

  def extracted_data
    @extracted_data ||= report_file.read
  end

  def check_file
    return if readable? report_file

    flash[:error] = [error_msg(type: 'Invalid file type', expected: 'Arquivo de texto', value: 'Binário')]
    redirect_to new_sale_path
  end
end
